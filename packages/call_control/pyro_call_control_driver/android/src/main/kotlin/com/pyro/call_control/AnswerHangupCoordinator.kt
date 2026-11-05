package com.pyro.call_control

import android.content.Context
import android.media.AudioManager
import android.util.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

/**
 * Coordinator for executing ANSWER_THEN_HANGUP with microsecond background privacy protection (microphone mute guard).
 */
object AnswerHangupCoordinator {
    private const val TAG = "AnswerHangupCoordinator"
    private val scope = CoroutineScope(Dispatchers.Default)

    /**
     * Physical microphone mute guard.
     */
    fun setMicrophoneMuted(context: Context, muted: Boolean): Boolean {
        return try {
            val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as? AudioManager
            if (audioManager != null) {
                audioManager.isMicrophoneMute = muted
                Log.d(TAG, "Microphone mute state changed to: $muted")
                true
            } else {
                false
            }
        } catch (e: Exception) {
            Log.e(TAG, "Failed to toggle microphone mute: ${e.message}", e)
            false
        }
    }

    /**
     * Execute answer-then-hangup workflow:
     * 1. Microsecond physical microphone closure (mic mute guard) to prevent ambient sound theft
     * 2. Invoke onAnswerAction() to accept ringing call via Android Telecom API
     * 3. Delay for configured duration (e.g. 1000ms)
     * 4. Invoke onHangupAction() to terminate call
     * 5. Restore original microphone state
     */
    fun scheduleAnswerThenHangup(
        context: Context,
        delayMs: Long,
        enableMicMuteProtection: Boolean,
        onAnswerAction: () -> Unit,
        onHangupAction: () -> Unit
    ) {
        scope.launch {
            var originallyMuted = false
            val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as? AudioManager

            try {
                if (enableMicMuteProtection && audioManager != null) {
                    originallyMuted = audioManager.isMicrophoneMute
                    audioManager.isMicrophoneMute = true
                    Log.i(TAG, "[Privacy Guard] Microsecond mic mute ENABLED before call pickup.")
                }

                // 1. Accept ringing call
                Log.i(TAG, "Executing acceptRingingCall action...")
                onAnswerAction()

                // 2. Hold for configured duration
                delay(delayMs.coerceAtLeast(100L))

                // 3. Hangup active call
                Log.i(TAG, "Executing hangup callback after ${delayMs}ms delay.")
                onHangupAction()
            } catch (e: Exception) {
                Log.e(TAG, "Error in AnswerHangupCoordinator execution: ${e.message}", e)
            } finally {
                if (enableMicMuteProtection && audioManager != null) {
                    // Restore original mic mute state
                    audioManager.isMicrophoneMute = originallyMuted
                    Log.i(TAG, "[Privacy Guard] Mic mute state RESTORED to: $originallyMuted.")
                }
            }
        }
    }
}
