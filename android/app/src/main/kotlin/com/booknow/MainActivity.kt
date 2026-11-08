package com.booknow

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.UiModeManager
import android.graphics.drawable.ColorDrawable
import android.os.Build
import android.os.Bundle
import android.util.TypedValue
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// flutter_stripe presents the Payment Sheet as a fragment, so the host
// activity has to be a FlutterFragmentActivity rather than a FlutterActivity.
class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createBookingsChannel()

        // Left alone, some phones fade the launch screen out, and the mark
        // dims and comes back. SplashView opens on the same picture, so it can
        // simply go.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { it.remove() }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LAUNCH_SCREEN_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "followTheme" -> {
                        followTheme(call.arguments as String)
                        result.success(null)
                    }
                    "release" -> {
                        releaseWindowBackground()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Tells Android the theme chosen in the app. It is what the launch screen
     * is drawn from, before any Flutter runs, so without this the launch screen
     * follows the phone even when the app has been set to the opposite.
     */
    private fun followTheme(mode: String) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) return

        getSystemService(UiModeManager::class.java).setApplicationNightMode(
            when (mode) {
                "light" -> UiModeManager.MODE_NIGHT_NO
                "dark" -> UiModeManager.MODE_NIGHT_YES
                else -> UiModeManager.MODE_NIGHT_AUTO
            },
        )
    }

    /**
     * NormalTheme keeps the launch picture behind Flutter for the handoff. Past
     * the splash it would show wherever the app's surface lags, as it does for
     * a moment when the keyboard opens.
     */
    private fun releaseWindowBackground() {
        val background = TypedValue()
        theme.resolveAttribute(android.R.attr.colorBackground, background, true)
        window.setBackgroundDrawable(ColorDrawable(background.data))
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

        /** Must match `LaunchScreen` on the Dart side. */
        const val LAUNCH_SCREEN_CHANNEL = "com.booknow/launch_screen"
    }
}
