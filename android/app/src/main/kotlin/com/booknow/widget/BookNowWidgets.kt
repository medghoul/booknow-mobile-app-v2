package com.booknow.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import com.booknow.MainActivity
import com.booknow.R
import es.antonborri.home_widget.HomeWidgetProvider

/**
 * Places the finished strings the app wrote (lib/features/home_widgets) into a
 * layout. Nothing is decided here except one thing the app cannot do once it is
 * closed: noticing that what it wrote can no longer be believed.
 */
abstract class BookNowWidget(
    private val prefix: String,
    private val layout: Int,
    private val slots: Map<String, Int>,
    private val hasTone: Boolean = true,
) : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        manager: AppWidgetManager,
        ids: IntArray,
        data: SharedPreferences,
    ) {
        ids.forEach { manager.updateAppWidget(it, render(context, data)) }
    }

    private fun render(context: Context, data: SharedPreferences): RemoteViews {
        val views = RemoteViews(context.packageName, layout)
        val freshUntil = data.getString("${prefix}_freshUntil", null)?.toLongOrNull()
        val stale = freshUntil != null && System.currentTimeMillis() > freshUntil

        fun value(slot: String): String = when {
            freshUntil == null ->
                if (slot == "title") context.getString(R.string.widget_open_app) else ""
            stale -> if (slot == "title") data.getString("${prefix}_stale", "").orEmpty() else ""
            else -> data.getString("${prefix}_$slot", "").orEmpty()
        }

        slots.forEach { (slot, id) ->
            val text = value(slot)
            views.setTextViewText(id, text)
            views.setViewVisibility(id, if (text.isEmpty()) View.GONE else View.VISIBLE)
        }

        if (hasTone) {
            val green = !stale && data.getString("${prefix}_tone", null) == "green"
            views.setInt(
                R.id.widget_root,
                "setBackgroundResource",
                if (green) R.drawable.widget_background_turn else R.drawable.widget_background,
            )
        }

        views.setOnClickPendingIntent(R.id.widget_root, openApp(context))
        slots["action"]?.let { id ->
            val geo = if (stale) null else data.getString("${prefix}_geo", null)
            if (!geo.isNullOrEmpty()) {
                views.setOnClickPendingIntent(id, openMaps(context, geo))
            }
        }

        return views
    }

    private fun openApp(context: Context): PendingIntent = PendingIntent.getActivity(
        context,
        0,
        Intent(context, MainActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP),
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
    )

    private fun openMaps(context: Context, geo: String): PendingIntent = PendingIntent.getActivity(
        context,
        1,
        Intent(Intent.ACTION_VIEW, Uri.parse(geo)).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
    )
}

private val rowSlots = mapOf(
    "row1Lead" to R.id.widget_row1_lead,
    "row1Name" to R.id.widget_row1_name,
    "row1Line" to R.id.widget_row1_line,
    "row2Lead" to R.id.widget_row2_lead,
    "row2Name" to R.id.widget_row2_name,
    "row2Line" to R.id.widget_row2_line,
    "row3Lead" to R.id.widget_row3_lead,
    "row3Name" to R.id.widget_row3_name,
    "row3Line" to R.id.widget_row3_line,
    "row4Lead" to R.id.widget_row4_lead,
    "row4Name" to R.id.widget_row4_name,
    "row4Line" to R.id.widget_row4_line,
)

class CustomerSmallWidget : BookNowWidget(
    "c",
    R.layout.widget_small,
    mapOf(
        "overline" to R.id.widget_overline,
        "big" to R.id.widget_big,
        "caption" to R.id.widget_caption,
        "title" to R.id.widget_title,
    ),
)

class CustomerMediumWidget : BookNowWidget(
    "c",
    R.layout.widget_medium,
    mapOf(
        "overline" to R.id.widget_overline,
        "big" to R.id.widget_big,
        "caption" to R.id.widget_caption,
        "title" to R.id.widget_title,
        "line" to R.id.widget_line,
        "foot" to R.id.widget_foot,
        "action" to R.id.widget_action,
    ),
)

class OwnerSmallWidget : BookNowWidget(
    "o",
    R.layout.widget_small,
    mapOf(
        "overline" to R.id.widget_overline,
        "big" to R.id.widget_big,
        "caption" to R.id.widget_caption,
        "title" to R.id.widget_title,
    ),
)

class OwnerMediumWidget : BookNowWidget(
    "o",
    R.layout.widget_medium,
    mapOf(
        "overline" to R.id.widget_overline,
        "big" to R.id.widget_big,
        "caption" to R.id.widget_caption,
        "title" to R.id.widget_title,
        "line" to R.id.widget_line,
        "foot" to R.id.widget_foot,
        "action" to R.id.widget_action,
    ),
)

class OwnerLargeWidget : BookNowWidget(
    "o",
    R.layout.widget_large,
    mapOf(
        "overline" to R.id.widget_overline,
        "summary" to R.id.widget_summary,
        "title" to R.id.widget_title,
    ) + rowSlots,
)
