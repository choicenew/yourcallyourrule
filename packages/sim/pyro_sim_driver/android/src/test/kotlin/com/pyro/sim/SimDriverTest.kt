package com.pyro.sim

import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Test

class SimDriverTest {

    @Test
    fun testPigeonSimCardSerialization() {
        val card = PigeonSimCard(
            subscriptionId = 1L,
            simSlotIndex = 0L,
            carrierName = "China Telecom",
            displayName = "CT",
            countryIso = "cn",
            iccId = "89860300000000",
            mccString = "460",
            mncString = "11",
            simPhoneNumber = "18900000000",
            isDataRoaming = false,
            isNetworkRoaming = false,
            state = "ready"
        )

        val list = card.toList()
        assertEquals(12, list.size)
        assertEquals(1L, list[0])
        assertEquals(0L, list[1])
        assertEquals("China Telecom", list[2])
        assertEquals("CT", list[3])
        assertEquals("cn", list[4])
        assertEquals("89860300000000", list[5])
        assertEquals("460", list[6])
        assertEquals("11", list[7])
        assertEquals("18900000000", list[8])
        assertEquals(false, list[9])
        assertEquals(false, list[10])
        assertEquals("ready", list[11])

        val restored = PigeonSimCard.fromList(list)
        assertEquals(card.subscriptionId, restored.subscriptionId)
        assertEquals(card.simSlotIndex, restored.simSlotIndex)
        assertEquals(card.carrierName, restored.carrierName)
        assertEquals(card.displayName, restored.displayName)
        assertEquals(card.countryIso, restored.countryIso)
        assertEquals(card.iccId, restored.iccId)
        assertEquals(card.mccString, restored.mccString)
        assertEquals(card.mncString, restored.mncString)
        assertEquals(card.simPhoneNumber, restored.simPhoneNumber)
        assertEquals(card.isDataRoaming, restored.isDataRoaming)
        assertEquals(card.isNetworkRoaming, restored.isNetworkRoaming)
        assertEquals(card.state, restored.state)
    }

    @Test
    fun testPigeonNetworkInfoSerialization() {
        val info = PigeonNetworkInfo(
            networkOperatorName = "CMCC",
            networkOperator = "46000",
            networkType = "5G",
            isNetworkAvailable = true,
            isRoaming = false
        )

        val list = info.toList()
        assertEquals(5, list.size)
        assertEquals("CMCC", list[0])
        assertEquals("46000", list[1])
        assertEquals("5G", list[2])
        assertEquals(true, list[3])
        assertEquals(false, list[4])

        val restored = PigeonNetworkInfo.fromList(list)
        assertEquals(info.networkOperatorName, restored.networkOperatorName)
        assertEquals(info.networkOperator, restored.networkOperator)
        assertEquals(info.networkType, restored.networkType)
        assertEquals(info.isNetworkAvailable, restored.isNetworkAvailable)
        assertEquals(info.isRoaming, restored.isRoaming)
    }

    @Test
    fun testNullSafetyInRestoration() {
        val card = PigeonSimCard()
        val list = card.toList()
        val restored = PigeonSimCard.fromList(list)
        assertNull(restored.subscriptionId)
        assertNull(restored.simSlotIndex)
        assertNull(restored.carrierName)
        assertNull(restored.state)
    }
}
