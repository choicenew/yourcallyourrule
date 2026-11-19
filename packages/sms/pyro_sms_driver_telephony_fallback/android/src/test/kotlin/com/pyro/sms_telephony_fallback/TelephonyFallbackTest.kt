package com.pyro.sms_telephony_fallback

import org.junit.Assert.assertEquals
import org.junit.Test

class TelephonyFallbackTest {

    @Test
    fun testPigeonTelephonySmsPayloadSerialization() {
        val payload = PigeonTelephonySmsPayload(
            id = "sms_1710000000000",
            sender = "+8613800000000",
            body = "Verification code: 888999",
            timestampMs = 1710000000000L
        )

        val list = payload.toList()
        assertEquals(4, list.size)
        assertEquals("sms_1710000000000", list[0])
        assertEquals("+8613800000000", list[1])
        assertEquals("Verification code: 888999", list[2])
        assertEquals(1710000000000L, list[3])

        val restored = PigeonTelephonySmsPayload.fromList(list)
        assertEquals(payload.id, restored.id)
        assertEquals(payload.sender, restored.sender)
        assertEquals(payload.body, restored.body)
        assertEquals(payload.timestampMs, restored.timestampMs)
    }

    @Test
    fun testPayloadWithNulls() {
        val payload = PigeonTelephonySmsPayload(
            id = null,
            sender = null,
            body = null,
            timestampMs = null
        )

        val list = payload.toList()
        assertEquals(4, list.size)

        val restored = PigeonTelephonySmsPayload.fromList(list)
        assertEquals(null, restored.id)
        assertEquals(null, restored.sender)
        assertEquals(null, restored.body)
        assertEquals(null, restored.timestampMs)
    }
}

