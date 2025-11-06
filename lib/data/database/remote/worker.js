/**
 * @file worker.js
 * @version 8.0.0 (FINAL COMPLETE IMPLEMENTATION)
 * @description Cloudflare Worker with complete Community Deletion Arbiter system.
 * This definitive version integrates all final decisions. NO CODE IS OMITTED.
 */

// =============================================================================
// SECTION 1: MAIN ENTRY POINT (FETCH & CRON HANDLER)
// =============================================================================
export default {
  /**
   * Handles all incoming API requests from the Flutter client.
   */
  async fetch(request, env) {
    if (request.headers.get('X-API-SECRET') !== env.API_SECRET) {
      return errorResponse('Unauthorized', 401);
    }
    const url = new URL(request.url);
    try {
      if (url.pathname === '/sync') {
        if (request.method === 'POST') return await handlePush(request, env);
        if (request.method === 'GET') return await handlePull(request, env);
        return errorResponse('Method Not Allowed on /sync', 405);
      }
      if (url.pathname === '/api/verification-reports') {
        return await handleVerificationReports(request, env);
      }
      if (url.pathname === '/api/v1/config/proposal-limits') {
        if (request.method === 'GET') return await handleGetProposalLimits(request, env);
        return errorResponse('Method Not Allowed on /api/v1/config/proposal-limits', 405);
      }
      return errorResponse('Not Found', 404);
    } catch (e) {
      console.error(`Unhandled fetch error: ${e.stack}`);
      return errorResponse('Internal Server Error', 500);
    }
  },

  /**
   * Handles scheduled events (Cron Triggers) to run the automated arbiter.
   */
  async scheduled(event, env, ctx) {
    // You can differentiate crons by their schedule string defined in the dashboard.
    // e.g., "0 * * * *" for arbitration, "0 5 * * *" for daily cleanup at 5 AM UTC.
    switch (event.cron) {
      case "0 * * * *": // Every hour
        console.log("Dispatching to Arbiter Cron...");
        ctx.waitUntil(handleCron(env));
        break;
      case "0 5 * * *": // Daily at 5 AM UTC
        console.log("Dispatching to Log Cleanup Cron...");
        ctx.waitUntil(handleLogCleanupCron(env));
        break;
      default:
        console.log(`Cron triggered with unknown schedule: ${event.cron}`);
        ctx.waitUntil(handleCron(env));
        break;
    }
  }
};

// =============================================================================
// SECTION 2: API HANDLERS
// =============================================================================

/**
 * Handles the 'push' of operations from clients (POST /sync).
 * It separates regular operations from deletion proposals and processes them.
 */
async function handlePush(request, env) {
  const { operations, sourceDeviceId } = await request.json();
  if (!Array.isArray(operations) || !sourceDeviceId) {
    return errorResponse('Invalid request body.', 400);
  }
  
  const regularOps = operations.filter(op => op.operation !== 'PROPOSE_DELETION');
  const proposalOps = operations.filter(op => op.operation === 'PROPOSE_DELETION');

  const dbStmts = [];

  // --- 1. Process Deletion Proposals ---
  for (const op of proposalOps) {
    const { entityId: phoneNumber, payload, timestamp } = op;
    const report = payload.report || {};
    const riskLevel = report.finalRisk || 'High';
    const isOwner = report.isNumberMatch === true;
    const ownerIncrement = isOwner ? 1 : 0;

    dbStmts.push(
      env.DB.prepare('INSERT INTO op_log (log_id, phoneNumber, operation, payload, timestamp, source_device_id) VALUES (?, ?, ?, ?, ?, ?)')
        .bind(crypto.randomUUID(), phoneNumber, 'PROPOSE_DELETION', JSON.stringify(payload), timestamp, sourceDeviceId)
    );
    
    dbStmts.push(
      env.DB.prepare(
        `INSERT INTO deletion_proposals (phoneNumber, proposal_start_time, highest_risk_level, verified_owner_count, proposal_count)
         VALUES (?, ?, ?, ?, 1)
         ON CONFLICT(phoneNumber) DO UPDATE SET
           proposal_count = proposal_count + 1,
           verified_owner_count = verified_owner_count + ?,
           highest_risk_level = CASE
             WHEN excluded.highest_risk_level = 'Verified' THEN 'Verified'
             WHEN highest_risk_level = 'Verified' THEN 'Verified'
             WHEN excluded.highest_risk_level = 'Low' THEN 'Low'
             ELSE highest_risk_level
           END`
      ).bind(phoneNumber, timestamp, riskLevel, ownerIncrement, ownerIncrement)
    );

    // Store verification report if provided
    if (payload.report) {
      dbStmts.push(
        env.DB.prepare(
          'INSERT INTO verification_reports (phoneNumber, report_data, uploaded_at, device_id) VALUES (?, ?, ?, ?)'
        ).bind(
          phoneNumber,
          JSON.stringify(payload.report),
          timestamp,
          sourceDeviceId
        )
      );
    }
  }

  // --- 2. Process Regular Operations (VOTE, INSERT, UPDATE) ---
  if (regularOps.length > 0) {
     const regularStmts = await processRegularOps(regularOps, sourceDeviceId, env);
     dbStmts.push(...regularStmts);
  }

  // --- 3. Atomically execute all batched statements ---
  if (dbStmts.length > 0) {
    await env.DB.batch(dbStmts);
  }

  return jsonResponse({ success: true, message: 'Operations processed.' });
}

/**
 * Handles client data pulls, broadcasting final states and active proposal information.
 */
async function handlePull(request, env) {
    const url = new URL(request.url);
    const since = url.searchParams.get('since');
    const deviceId = url.searchParams.get('deviceId');
    const countryCodesParam = url.searchParams.get('countryCodes');
    if (!since || !deviceId || !countryCodesParam) {
      return errorResponse('Query parameters "since", "deviceId", and "countryCodes" are required.', 400);
    }
    const countryCodes = countryCodesParam.split(',').filter(c => c);
    if (countryCodes.length === 0) return jsonResponse({ operations: [] });
    
    const placeholders = countryCodes.map(() => '?').join(',');
    const bindings = [since, deviceId, ...countryCodes, ...countryCodes];
    const finalOperations = [];

    // --- 1. State-Based Sync: Find affected numbers ---
    const affectedNumbersQuery = `
      SELECT DISTINCT op.phoneNumber, op.operation
      FROM op_log AS op
      WHERE
        op.timestamp > ? AND op.source_device_id != ? AND (
          (op.operation != 'DELETE' AND EXISTS (
            SELECT 1 FROM number_countries nc WHERE nc.phoneNumber = op.phoneNumber AND nc.countryIsoCode IN (${placeholders})
          )) OR 
          (op.operation = 'DELETE' AND json_extract(op.payload, '$.countryIsoCode') IN (${placeholders}))
        )`;
    const { results: affectedLogs } = await env.DB.prepare(affectedNumbersQuery).bind(...bindings).all();

    if (affectedLogs && affectedLogs.length > 0) {
        const numbersToUpdate = new Set();
        const numbersToDelete = new Set();
        for (const log of affectedLogs) {
            if (log.operation === 'DELETE') {
                numbersToDelete.add(log.phoneNumber);
                numbersToUpdate.delete(log.phoneNumber);
            } else {
                numbersToUpdate.add(log.phoneNumber);
            }
        }

        if (numbersToUpdate.size > 0) {
            const updatePlaceholders = Array.from(numbersToUpdate).map(() => '?').join(',');
            const { results: currentStates } = await env.DB.prepare(
              `SELECT * FROM remote_numbers WHERE phoneNumber IN (${updatePlaceholders})`
            ).bind(...numbersToUpdate).all();
            for (const state of currentStates) {
                finalOperations.push({
                    entityId: state.phoneNumber, operation: 'UPDATE', payload: state,
                });
            }
        }
        for (const phoneNumber of numbersToDelete) {
            finalOperations.push({ entityId: phoneNumber, operation: 'DELETE', payload: null });
        }
    }

    // --- 2. Proposal Broadcasting ---
    const proposalsQuery = `
        SELECT p.*, r.labels_json
        FROM deletion_proposals p
        LEFT JOIN remote_numbers r ON p.phoneNumber = r.phoneNumber
        WHERE p.status = 'pending' AND EXISTS (
            SELECT 1 FROM number_countries nc
            WHERE nc.phoneNumber = p.phoneNumber AND nc.countryIsoCode IN (${placeholders})
        )
    `;
    const { results: activeProposals } = await env.DB.prepare(proposalsQuery).bind(...countryCodes).all();

    for (const proposal of activeProposals) {
        // Get latest verification report
        const latestReportQuery = await env.DB.prepare(
          `SELECT report_data FROM verification_reports 
           WHERE phoneNumber = ? ORDER BY uploaded_at DESC LIMIT 1`
        ).bind(proposal.phoneNumber).first();
        
        const latestReport = latestReportQuery ? JSON.parse(latestReportQuery.report_data) : null;

        let totalVotesN = 0, agreeVotes = 0;
        if (proposal.labels_json) {
            const votes = JSON.parse(proposal.labels_json);
            agreeVotes = votes['proposal_agree_delete'] || 0;
            totalVotesN = Object.values(votes).reduce((sum, count) => sum + count, 0);
        }

        finalOperations.push({
            operation: 'DELETION_PROPOSAL_INFO',
            entityId: proposal.phoneNumber,
            payload: {
                proposalCount: proposal.proposal_count,
                highestTrustLevel: proposal.highest_risk_level,
                verifiedOwnerCount: proposal.verified_owner_count,
                currentDeleteRatio: totalVotesN > 0 ? (agreeVotes / totalVotesN) : 0,
                verificationReportJson: latestReport ? JSON.stringify(latestReport) : null
            }
        });
    }
    
    return jsonResponse({ operations: finalOperations });
}

async function handleGetProposalLimits(request, env) {
  try {
    const stmt = env.DB.prepare("SELECT * FROM app_config WHERE key LIKE 'proposal_limit_%'");
    const { results } = await stmt.all();
    
    if (!results) {
      return errorResponse('Configuration not found.', 404);
    }

    const config = results.reduce((acc, { key, value }) => {
      const newKey = key.replace('proposal_limit_', '');
      acc[newKey] = value;
      return acc;
    }, {});

    return jsonResponse(config);
  } catch (error) {
    console.error('Error fetching proposal limits config:', error);
    return errorResponse('Failed to fetch configuration.', 500);
  }
}

// =============================================================================
// SECTION 3: VERIFICATION REPORTS HANDLER
// =============================================================================

async function handleVerificationReports(request, env) {
  const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-API-Key',
  };

  try {
    if (request.method === 'GET') {
      return await getVerificationReports(request, env, corsHeaders);
    } else if (request.method === 'POST') {
      return await uploadVerificationReport(request, env, corsHeaders);
    }
    return errorResponse('Method not allowed', 405, corsHeaders);
  } catch (error) {
    console.error('Error handling verification reports:', error);
    return errorResponse('Failed to handle verification report request', 500, corsHeaders);
  }
}

/**
 * Get verification reports
 */
async function getVerificationReports(request, env, corsHeaders) {
  const url = new URL(request.url);
  const phoneNumber = url.searchParams.get('phoneNumber');
  
  if (!phoneNumber) {
    return errorResponse('Phone number is required', 400, corsHeaders);
  }
  
  try {
    const reports = await env.DB.prepare(
      'SELECT * FROM verification_reports WHERE phoneNumber = ? ORDER BY uploaded_at DESC'
    ).bind(phoneNumber).all();
    
    return jsonResponse({ reports: reports.results }, 200, corsHeaders);
  } catch (error) {
    console.error('Error fetching verification reports:', error);
    return errorResponse('Failed to fetch verification reports', 500, corsHeaders);
  }
}

/**
 * Upload verification report
 */
async function uploadVerificationReport(request, env, corsHeaders) {
  try {
    const { phoneNumber, reportData, deviceId } = await request.json();
    
    if (!phoneNumber || !reportData) {
      return errorResponse('Phone number and report data are required', 400, corsHeaders);
    }
    
    await env.DB.prepare(
      'INSERT INTO verification_reports (phoneNumber, report_data, uploaded_at, device_id) VALUES (?, ?, ?, ?)'
    ).bind(
      phoneNumber,
      JSON.stringify(reportData),
      new Date().toISOString(),
      deviceId || 'unknown'
    ).run();
    
    return jsonResponse({ success: true, message: 'Verification report uploaded' }, 201, corsHeaders);
  } catch (error) {
    console.error('Error uploading verification report:', error);
    return errorResponse('Failed to upload verification report', 500, corsHeaders);
  }
}

// =============================================================================
// SECTION 4: CRON HANDLERS & HELPERS
// =============================================================================

/**
 * Runs on a schedule to automatically process expired proposals using the
 * full "Weighted Consensus" rule, including neutral votes.
 */
async function handleCron(env) {
  console.log("Cron triggered: Processing expired deletion proposals...");
  const sevenDaysAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString();

  const expiredProposals = await env.DB.prepare(
    `SELECT p.phoneNumber, r.labels_json FROM deletion_proposals p
     LEFT JOIN remote_numbers r ON p.phoneNumber = r.phoneNumber
     WHERE p.status = 'pending' AND p.proposal_start_time < ?`
  ).bind(sevenDaysAgo).all();

  if (!expiredProposals.results || expiredProposals.results.length === 0) {
    console.log("No expired proposals to process.");
    return;
  }

  const stmts = [];
  for (const proposal of expiredProposals.results) {
    const { phoneNumber, labels_json } = proposal;
    
    let totalVotesN = 0, agreeVotes = 0, disagreeVotes = 0, neutralVotes = 0;
    if (labels_json) {
      try {
        const votes = JSON.parse(labels_json);
        for (const [label, count] of Object.entries(votes)) {
          if (label === 'proposal_agree_delete') agreeVotes += count;
          else if (label === 'proposal_disagree_delete') disagreeVotes += count;
          else neutralVotes += count;
        }
        totalVotesN = agreeVotes + disagreeVotes + neutralVotes;
      } catch (e) { console.error(`Error parsing labels_json for ${phoneNumber}: ${e}`); }
    }
    
    const ratio = totalVotesN > 0 ? (agreeVotes / totalVotesN) : 0;
    const hasMajority = agreeVotes > disagreeVotes;

    if (hasMajority && ratio >= 0.4) {
      console.log(`Consensus REACHED for ${phoneNumber}. Approving and deleting.`);
      stmts.push(env.DB.prepare("UPDATE deletion_proposals SET status = 'approved' WHERE phoneNumber = ?").bind(phoneNumber));
      stmts.push(env.DB.prepare("DELETE FROM remote_numbers WHERE phoneNumber = ?").bind(phoneNumber));
      
      const countryRes = await env.DB.prepare("SELECT countryIsoCode FROM number_countries WHERE phoneNumber = ? LIMIT 1").bind(phoneNumber).first();
      stmts.push(
        env.DB.prepare('INSERT INTO op_log (log_id, phoneNumber, operation, payload, source_device_id, timestamp) VALUES (?, ?, ?, ?, ?, ?)')
          .bind(crypto.randomUUID(), phoneNumber, 'DELETE', JSON.stringify({ countryIsoCode: countryRes?.countryIsoCode }), 'SYSTEM_ARBITER', new Date().toISOString())
      );
    } else {
      console.log(`Consensus FAILED for ${phoneNumber}. Rejecting.`);
      stmts.push(env.DB.prepare("UPDATE deletion_proposals SET status = 'rejected' WHERE phoneNumber = ?").bind(phoneNumber));
    }
  }

  if (stmts.length > 0) {
    await env.DB.batch(stmts);
    console.log(`Processed ${expiredProposals.results.length} proposals.`);
  }
}

/**
 * [NEW] Runs on a separate, less frequent schedule (e.g., once daily)
 * to clean up old operation logs, controlling storage costs and maintaining performance.
 */
async function handleLogCleanupCron(env) {
  console.log("Log Cleanup Cron triggered: Deleting old operation logs...");

  // Define the retention period. 30 days is a reasonable default.
  const RETENTION_DAYS = 30;
  const cutoffDate = new Date(Date.now() - RETENTION_DAYS * 24 * 60 * 60 * 1000).toISOString();

  try {
    // Prepare the DELETE statement
    const stmt = env.DB.prepare("DELETE FROM op_log WHERE timestamp < ?").bind(cutoffDate);
    
    // Execute the deletion
    const { success, meta } = await stmt.run();

    if (success) {
      console.log(`Successfully executed log cleanup. Cutoff date: ${cutoffDate}. Operation successful.`);
    } else {
      console.error("Log cleanup failed.", meta);
    }
  } catch (e) {
    console.error(`Error during log cleanup: ${e.stack}`);
  }
}

/**
 * Processes regular operations like VOTE, INSERT, UPDATE using the
 * "Batch Read -> In-Memory Compute -> Batch Write" pattern.
 */
async function processRegularOps(operations, sourceDeviceId, env) {
  const finalStmts = [];
  const opsByPhoneNumber = {};
  for (const op of operations) {
    if (!op.entityId) continue;
    if (!opsByPhoneNumber[op.entityId]) opsByPhoneNumber[op.entityId] = [];
    opsByPhoneNumber[op.entityId].push(op);
  }

  const phoneNumbersToProcess = Object.keys(opsByPhoneNumber);
  if (phoneNumbersToProcess.length === 0) return [];

  const placeholders = phoneNumbersToProcess.map(() => '?').join(',');
  const { results: existingRecords } = await env.DB.prepare(
    `SELECT * FROM remote_numbers WHERE phoneNumber IN (${placeholders})`
  ).bind(...phoneNumbersToProcess).all();
  const recordsMap = new Map(existingRecords.map(r => [r.phoneNumber, r]));

  for (const phoneNumber of phoneNumbersToProcess) {
    const ops = opsByPhoneNumber[phoneNumber];
    let currentRecord = recordsMap.get(phoneNumber);

    if (!currentRecord) {
      const firstPayload = ops.find(op => op.payload)?.payload;
      if (!firstPayload) continue;
      currentRecord = {
        phoneNumber: phoneNumber, id: firstPayload.id || crypto.randomUUID(), name: firstPayload.name || null,
        label: '', priority: firstPayload.priority || 0, action: firstPayload.action || 'none',
        count: 0, labels_json: '{}',
      };
    }

    let finalState = { ...currentRecord };
    let currentVotes = {};
    try {
        currentVotes = JSON.parse(finalState.labels_json || '{}');
    } catch(e) { /* malformed json, start fresh */ }

    for (const op of ops) {
      finalStmts.push(
        env.DB.prepare('INSERT INTO op_log (log_id, phoneNumber, operation, payload, timestamp, source_device_id) VALUES (?, ?, ?, ?, ?, ?)')
          .bind(crypto.randomUUID(), phoneNumber, op.operation, JSON.stringify(op.payload), op.timestamp, sourceDeviceId)
      );

      const payload = op.payload;
      switch (op.operation) {
        case 'INSERT': case 'UPDATE':
          if (payload) {
            finalState.name = payload.name ?? finalState.name;
            finalState.priority = payload.priority ?? finalState.priority;
            finalState.action = payload.action ?? finalState.action;
            finalState.id = payload.id ?? finalState.id;
          }
          break;
        case 'VOTE':
          if (payload?.label) {
            const vote = payload.label;
            currentVotes[vote] = (currentVotes[vote] || 0) + 1;
          }
          break;
      }
    }

    finalState.count = Object.values(currentVotes).reduce((sum, count) => sum + count, 0);

    let winner = finalState.label;
    if (Object.keys(currentVotes).length > 0) {
      winner = Object.entries(currentVotes).reduce((a, b) => a[1] > b[1] ? a : b)[0];
    }
    finalState.label = winner;
    finalState.labels_json = JSON.stringify(currentVotes);

    finalStmts.push(
      env.DB.prepare(
        `INSERT INTO remote_numbers (phoneNumber, id, name, label, priority, action, count, labels_json)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)
         ON CONFLICT(phoneNumber) DO UPDATE SET
           id=excluded.id, name=excluded.name, label=excluded.label, priority=excluded.priority,
           action=excluded.action, count=excluded.count, labels_json=excluded.labels_json`
      ).bind(
        finalState.phoneNumber, finalState.id, finalState.name, finalState.label,
        finalState.priority, finalState.action, finalState.count, finalState.labels_json
      )
    );
  }
  return finalStmts;
}

// =============================================================================
// SECTION 5: UTILITY FUNCTIONS
// =============================================================================

function jsonResponse(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { 'Content-Type': 'application/json;charset=UTF-8' },
  });
}

function errorResponse(message, status = 500) {
  return jsonResponse({ error: message }, status);
}

// =============================================================================
// SECTION 6: DATABASE SCHEMA (FOR REFERENCE)
// =============================================================================

/*
-- D1 数据库最终 Schema

-- 为保证部署的纯净性，先删除旧表 (仅用于首次部署或重置)
DROP TABLE IF EXISTS op_log;
DROP TABLE IF EXISTS number_countries;
DROP TABLE IF EXISTS deletion_proposals;
DROP TABLE IF EXISTS remote_numbers;
DROP TABLE IF EXISTS verification_reports;

-- 表 1: remote_numbers - 核心号码数据与投票记录
CREATE TABLE remote_numbers (
    phoneNumber TEXT PRIMARY KEY,
    id TEXT NOT NULL UNIQUE,
    name TEXT,
    label TEXT NOT NULL,
    priority INTEGER NOT NULL DEFAULT 0,
    action TEXT NOT NULL DEFAULT 'none',
    count INTEGER NOT NULL DEFAULT 0,
    labels_json TEXT -- 存储所有投票，包括同意/反对/中立票
);

-- 表 2: number_countries - 号码与国家关联
CREATE TABLE number_countries (
    phoneNumber TEXT NOT NULL,
    countryIsoCode TEXT NOT NULL,
    PRIMARY KEY (phoneNumber, countryIsoCode),
    FOREIGN KEY (phoneNumber) REFERENCES remote_numbers(phoneNumber) ON DELETE CASCADE
);
CREATE INDEX idx_nc_country_iso_code ON number_countries(countryIsoCode);

-- 表 3: op_log - 所有操作的流水日志
CREATE TABLE op_log (
    log_id TEXT PRIMARY KEY,
    phoneNumber TEXT NOT NULL,
    operation TEXT NOT NULL,
    payload TEXT,
    timestamp TEXT NOT NULL,
    source_device_id TEXT NOT NULL
);
CREATE INDEX idx_op_log_pull ON op_log(timestamp, source_device_id);

-- 表 4: deletion_proposals - 仲裁系统的状态机
CREATE TABLE deletion_proposals (
    phoneNumber TEXT PRIMARY KEY,
    proposal_start_time TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending', -- 'pending', 'approved', 'rejected'
    highest_risk_level TEXT NOT NULL,      -- 记录收到的最高信任等级 ('Verified', 'Low', etc.)
    proposal_count INTEGER NOT NULL DEFAULT 0,
    verified_owner_count INTEGER NOT NULL DEFAULT 0 -- 记录来自号码所有者的提案数
);

-- 表 5: verification_reports - 验证报告存储
CREATE TABLE verification_reports (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    phoneNumber TEXT NOT NULL,
    report_data TEXT NOT NULL,
    uploaded_at TEXT NOT NULL,
    device_id TEXT
);
CREATE INDEX idx_verification_reports_phone ON verification_reports(phoneNumber);
CREATE INDEX idx_verification_reports_uploaded ON verification_reports(uploaded_at);
*/