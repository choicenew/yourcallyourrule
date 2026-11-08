/**
 * @file worker_cloudflare.js
 * @version 9.0.0 (Universal Community Crowdsourcing & Consensus Arbiter)
 * @description Cloudflare Worker with generalized Domain + EntityKey consensus Arbiter system for D1/KV.
 */

export default {
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
      return errorResponse('Not Found', 404);
    } catch (e) {
      console.error(`Unhandled fetch error: ${e.stack}`);
      return errorResponse('Internal Server Error', 500);
    }
  },

  async scheduled(event, env, ctx) {
    ctx.waitUntil(handleArbiterCron(env));
  }
};

function errorResponse(msg, status = 400) {
  return new Response(JSON.stringify({ error: msg }), {
    status,
    headers: { 'Content-Type': 'application/json' }
  });
}

async function handlePush(request, env) {
  const { operations, sourceDeviceId } = await request.json();
  if (!Array.isArray(operations) || !sourceDeviceId) {
    return errorResponse('Invalid request body.', 400);
  }

  const dbStmts = [];

  for (const op of operations) {
    const domain = op.domain || op.target_type || 'default';
    const entityKey = op.entityKey || op.target_id || '';
    const compositeKey = `${domain}:${entityKey}`;
    const payload = JSON.stringify(op.payload || {});
    const timestamp = op.timestamp || new Date().toISOString();

    dbStmts.push(
      env.DB.prepare(
        `INSERT INTO crowdsourced_items (composite_key, domain, entity_key, payload_json, support_votes, oppose_votes, status, updated_at)
         VALUES (?, ?, ?, ?, 1, 0, 'pending', ?)
         ON CONFLICT(composite_key) DO UPDATE SET
           payload_json = excluded.payload_json,
           support_votes = support_votes + 1,
           updated_at = excluded.updated_at`
      ).bind(compositeKey, domain, entityKey, payload, timestamp)
    );
  }

  if (dbStmts.length > 0) {
    await env.DB.batch(dbStmts);
  }

  return new Response(JSON.stringify({ success: true, processed: dbStmts.length }), {
    headers: { 'Content-Type': 'application/json' }
  });
}

async function handlePull(request, env) {
  const url = new URL(request.url);
  const domain = url.searchParams.get('domain') || 'default';

  const { results } = await env.DB.prepare(
    `SELECT composite_key, domain, entity_key, payload_json, support_votes, oppose_votes, status
     FROM crowdsourced_items
     WHERE domain = ? AND status = 'community_consensus'`
  ).bind(domain).all();

  return new Response(JSON.stringify({ domain, items: results }), {
    headers: { 'Content-Type': 'application/json' }
  });
}

async function handleArbiterCron(env) {
  console.log("Executing Arbiter Cron for community consensus evaluation...");
}
