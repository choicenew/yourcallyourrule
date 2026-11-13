package com.pyro.call_control

import java.util.concurrent.ConcurrentHashMap

/**
 * Thread-safe, zero-disk-IO in-memory registry for pending call control tasks.
 * Eliminates the need for fragile SharedPreferences inter-service disk reads.
 */
object PendingActionRegistry {
    private val pendingTasks = ConcurrentHashMap<String, PendingTask>()

    data class PendingTask(
        val phoneNumber: String,
        val delayMs: Long,
        val enableMicMuteProtection: Boolean,
        val createdAtMs: Long = System.currentTimeMillis(),
        val ttlMs: Long = 10000L // 10-second safety net TTL for automatic stale cleanup
    )

    private fun normalize(phoneNumber: String): String {
        return phoneNumber.replace(Regex("[^0-9+]"), "")
    }

    /**
     * Register a pending answer-then-hangup action in memory before allowing call through screening.
     */
    fun registerPendingAnswerHangup(phoneNumber: String, delayMs: Long, enableMicMuteProtection: Boolean) {
        val key = normalize(phoneNumber)
        if (key.isNotEmpty()) {
            pendingTasks[key] = PendingTask(
                phoneNumber = key,
                delayMs = delayMs,
                enableMicMuteProtection = enableMicMuteProtection
            )
        }
    }

    /**
     * Atomically consume a pending action when InCallService detects the call added.
     * Returns null if no action is registered or if the task has expired past TTL.
     */
    fun consumePendingAction(phoneNumber: String): PendingTask? {
        val key = normalize(phoneNumber)
        val task = pendingTasks.remove(key) ?: return null

        // Auto-expire check
        if (System.currentTimeMillis() - task.createdAtMs > task.ttlMs) {
            return null
        }
        return task
    }

    /**
     * Clear all pending tasks.
     */
    fun clearAll() {
        pendingTasks.clear()
    }
}
