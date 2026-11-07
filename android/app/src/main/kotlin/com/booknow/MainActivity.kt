package com.booknow

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity

// flutter_stripe presents the Payment Sheet as a fragment, so the host
// activity has to be a FlutterFragmentActivity rather than a FlutterActivity.
class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createBookingsChannel()
    }

    /**
     * Creates the channel every BookNow push is delivered on.
     *
     * Android 8 and later refuses to show a notification whose channel does
     * not exist, and the `notifications` Lambda sends every message with
     * `android.notification.channelId = "bookings"`. Without this the push
     * would fall back to Firebase's own channel, which has no name a user
     * would recognise in Settings and only default importance — so a new
     * booking would arrive silently.
     *
     * Creating it again is a no-op, which is why there is no flag to track:
     * the name and description are refreshed, and anything the user has
     * changed about the channel is left alone. In the activity rather than in
     * an Application subclass because it is only needed once the app has
     * actually run — before that there is no token for anything to be sent to.
     */
    private fun createBookingsChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return

        val channel = NotificationChannel(
            BOOKINGS_CHANNEL_ID,
            getString(R.string.notification_channel_bookings),
            NotificationManager.IMPORTANCE_HIGH,
        ).apply {
            description = getString(R.string.notification_channel_bookings_description)
        }

        getSystemService(NotificationManager::class.java)
            .createNotificationChannel(channel)
    }

    private companion object {
        /**
         * Must match `android.notification.channelId` in the notifications
         * Lambda and the default-channel meta-data in AndroidManifest.xml.
         */
        const val BOOKINGS_CHANNEL_ID = "bookings"
    }
}
