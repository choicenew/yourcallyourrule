package com.pyro.sms_notification_listener

import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class SmsNotificationListenerTest {

    @Test
    fun testPigeonSmsNotificationPayloadSerialization() {
        val payload = PigeonSmsNotificationPayload(
            id = "notif_999",
            sender = "10086",
            body = "Your OTP is 654321",
            packageName = "com.android.mms",
            timestampMs = 1710000000000L
        )

        val list = payload.toList()
        assertEquals(5, list.size)
        assertEquals("notif_999", list[0])
        assertEquals("10086", list[1])
        assertEquals("Your OTP is 654321", list[2])
        assertEquals("com.android.mms", list[3])
        assertEquals(1710000000000L, list[4])

        val restored = PigeonSmsNotificationPayload.fromList(list)
        assertEquals(payload.id, restored.id)
        assertEquals(payload.sender, restored.sender)
        assertEquals(payload.body, restored.body)
        assertEquals(payload.packageName, restored.packageName)
        assertEquals(payload.timestampMs, restored.timestampMs)
    }

    @Test
    fun testPigeonSmsEvidencePayloadSerialization() {
        val evidence = PigeonSmsEvidencePayload(
            key = "ev_123",
            packageName = "com.tencent.mm",
            sender = "Spammer",
            body = "Click http://phishing.site",
            timestampMs = 1715000000000L
        )

        val list = evidence.toList()
        assertEquals(5, list.size)

        val restored = PigeonSmsEvidencePayload.fromList(list)
        assertEquals(evidence.key, restored.key)
        assertEquals(evidence.packageName, restored.packageName)
        assertEquals(evidence.sender, restored.sender)
        assertEquals(evidence.body, restored.body)
        assertEquals(evidence.timestampMs, restored.timestampMs)
    }

    @Test
    fun testProtectedPackagesManagement() {
        val pkgs = listOf("com.tencent.mm", "org.telegram.messenger")
        SmsNotificationListenerService.updateProtectedPackages(pkgs)

        val protectedSet = SmsNotificationListenerService.getProtectedPackages()
        assertTrue(protectedSet.contains("com.tencent.mm"))
        assertTrue(protectedSet.contains("org.telegram.messenger"))
        assertEquals(2, protectedSet.size)
    }
}

