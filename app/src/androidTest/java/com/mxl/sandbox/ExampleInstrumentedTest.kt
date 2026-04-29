package com.mxl.sandbox

import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.Assert.*

@RunWith(AndroidJUnit4::class)
class ExampleInstrumentedTest {

    @Test
    fun useAppContext() {
        val appContext = InstrumentationRegistry.getInstrumentation().targetContext
        assertEquals("com.mxl.sandbox", appContext.packageName)
    }

    @Test
    fun sdk_smoke_test() {
        println("🔥 SDK TEST EXECUTED")

        // simple deterministic check to confirm execution
        val result = 1 + 1
        assertEquals(2, result)
    }
}