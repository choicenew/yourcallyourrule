package com.yours.yourcallyourrule

import android.content.Context
import android.widget.RemoteViews
import android.util.Log
import com.yours.yourcallyourrule.R

class CustomLiveActivityManager(private val context: Context) {
    
    companion object {
        private const val TAG = "CustomLiveActivityManager"
    }

    /**
     * Creates a RemoteViews object for the live activity notification
     * @param data Map containing the notification data
     * @return RemoteViews configured with the provided data
     */
    fun createLiveActivityView(data: Map<String, Any?>): RemoteViews {
        val remoteViews = RemoteViews(context.packageName, R.layout.live_activity)
        
        try {
            // Process avatar
            val avatarVisible = data["avatarVisible"] as? Boolean ?: false
            val avatarUrl = data["avatarUrl"] as? String
            if (avatarVisible && !avatarUrl.isNullOrEmpty()) {
                remoteViews.setViewVisibility(R.id.avatar, android.view.View.VISIBLE)
                // Note: For network images, you'd need to implement image loading
                // For now, we'll use a placeholder or local resource
                remoteViews.setImageViewResource(R.id.avatar, android.R.drawable.ic_menu_call)
            } else {
                remoteViews.setViewVisibility(R.id.avatar, android.view.View.GONE)
            }

            // Process name
            val nameVisible = data["nameVisible"] as? Boolean ?: false
            val nameText = data["nameText"] as? String ?: ""
            if (nameVisible && nameText.isNotEmpty()) {
                remoteViews.setViewVisibility(R.id.name, android.view.View.VISIBLE)
                remoteViews.setTextViewText(R.id.name, nameText)
                
                // Apply styling if provided
                val nameColor = data["nameColor"] as? String
                if (!nameColor.isNullOrEmpty()) {
                    try {
                        val color = android.graphics.Color.parseColor(nameColor)
                        remoteViews.setTextColor(R.id.name, color)
                    } catch (e: IllegalArgumentException) {
                        Log.w(TAG, "Invalid name color: $nameColor")
                    }
                }
                
                val nameSize = data["nameSize"] as? Double
                if (nameSize != null && nameSize > 0) {
                    remoteViews.setTextViewTextSize(R.id.name, android.util.TypedValue.COMPLEX_UNIT_SP, nameSize.toFloat())
                }
            } else {
                remoteViews.setViewVisibility(R.id.name, android.view.View.GONE)
            }

            // Process carrier
            val carrierVisible = data["carrierVisible"] as? Boolean ?: false
            val carrierText = data["carrierText"] as? String ?: ""
            if (carrierVisible && carrierText.isNotEmpty()) {
                remoteViews.setViewVisibility(R.id.carrier, android.view.View.VISIBLE)
                remoteViews.setTextViewText(R.id.carrier, carrierText)
                
                val carrierColor = data["carrierColor"] as? String
                if (!carrierColor.isNullOrEmpty()) {
                    try {
                        val color = android.graphics.Color.parseColor(carrierColor)
                        remoteViews.setTextColor(R.id.carrier, color)
                    } catch (e: IllegalArgumentException) {
                        Log.w(TAG, "Invalid carrier color: $carrierColor")
                    }
                }
                
                val carrierSize = data["carrierSize"] as? Double
                if (carrierSize != null && carrierSize > 0) {
                    remoteViews.setTextViewTextSize(R.id.carrier, android.util.TypedValue.COMPLEX_UNIT_SP, carrierSize.toFloat())
                }
            } else {
                remoteViews.setViewVisibility(R.id.carrier, android.view.View.GONE)
            }

            // Process number
            val numberVisible = data["numberVisible"] as? Boolean ?: false
            val numberText = data["numberText"] as? String ?: ""
            if (numberVisible && numberText.isNotEmpty()) {
                remoteViews.setViewVisibility(R.id.number, android.view.View.VISIBLE)
                remoteViews.setTextViewText(R.id.number, numberText)
                
                val numberColor = data["numberColor"] as? String
                if (!numberColor.isNullOrEmpty()) {
                    try {
                        val color = android.graphics.Color.parseColor(numberColor)
                        remoteViews.setTextColor(R.id.number, color)
                    } catch (e: IllegalArgumentException) {
                        Log.w(TAG, "Invalid number color: $numberColor")
                    }
                }
                
                val numberSize = data["numberSize"] as? Double
                if (numberSize != null && numberSize > 0) {
                    remoteViews.setTextViewTextSize(R.id.number, android.util.TypedValue.COMPLEX_UNIT_SP, numberSize.toFloat())
                }
            } else {
                remoteViews.setViewVisibility(R.id.number, android.view.View.GONE)
            }

            // Process location
            val locationVisible = data["locationVisible"] as? Boolean ?: false
            val locationText = data["locationText"] as? String ?: ""
            if (locationVisible && locationText.isNotEmpty()) {
                remoteViews.setViewVisibility(R.id.location, android.view.View.VISIBLE)
                remoteViews.setTextViewText(R.id.location, locationText)
                
                val locationColor = data["locationColor"] as? String
                if (!locationColor.isNullOrEmpty()) {
                    try {
                        val color = android.graphics.Color.parseColor(locationColor)
                        remoteViews.setTextColor(R.id.location, color)
                    } catch (e: IllegalArgumentException) {
                        Log.w(TAG, "Invalid location color: $locationColor")
                    }
                }
                
                val locationSize = data["locationSize"] as? Double
                if (locationSize != null && locationSize > 0) {
                    remoteViews.setTextViewTextSize(R.id.location, android.util.TypedValue.COMPLEX_UNIT_SP, locationSize.toFloat())
                }
            } else {
                remoteViews.setViewVisibility(R.id.location, android.view.View.GONE)
            }

            // Process labels
            val labelsVisible = data["labelsVisible"] as? Boolean ?: false
            val labelsText = data["labelsText"] as? String ?: ""
            if (labelsVisible && labelsText.isNotEmpty()) {
                remoteViews.setViewVisibility(R.id.labels, android.view.View.VISIBLE)
                remoteViews.setTextViewText(R.id.labels, labelsText)
                
                val labelsColor = data["labelsColor"] as? String
                if (!labelsColor.isNullOrEmpty()) {
                    try {
                        val color = android.graphics.Color.parseColor(labelsColor)
                        remoteViews.setTextColor(R.id.labels, color)
                    } catch (e: IllegalArgumentException) {
                        Log.w(TAG, "Invalid labels color: $labelsColor")
                    }
                }
                
                val labelsSize = data["labelsSize"] as? Double
                if (labelsSize != null && labelsSize > 0) {
                    remoteViews.setTextViewTextSize(R.id.labels, android.util.TypedValue.COMPLEX_UNIT_SP, labelsSize.toFloat())
                }
            } else {
                remoteViews.setViewVisibility(R.id.labels, android.view.View.GONE)
            }

            // Process security message (scrolling)
            val securityVisible = data["securityVisible"] as? Boolean ?: false
            val securityText = data["securityText"] as? String ?: ""
            if (securityVisible && securityText.isNotEmpty()) {
                remoteViews.setViewVisibility(R.id.securityMessage, android.view.View.VISIBLE)
                remoteViews.setTextViewText(R.id.securityMessage, securityText)
                
                val securityColor = data["securityColor"] as? String
                if (!securityColor.isNullOrEmpty()) {
                    try {
                        val color = android.graphics.Color.parseColor(securityColor)
                        remoteViews.setTextColor(R.id.securityMessage, color)
                    } catch (e: IllegalArgumentException) {
                        Log.w(TAG, "Invalid security message color: $securityColor")
                    }
                }
                
                val securitySize = data["securitySize"] as? Double
                if (securitySize != null && securitySize > 0) {
                    remoteViews.setTextViewTextSize(R.id.securityMessage, android.util.TypedValue.COMPLEX_UNIT_SP, securitySize.toFloat())
                }
            } else {
                remoteViews.setViewVisibility(R.id.securityMessage, android.view.View.GONE)
            }

            Log.d(TAG, "Live activity view created successfully")
            
        } catch (e: Exception) {
            Log.e(TAG, "Error creating live activity view", e)
        }
        
        return remoteViews
    }

    /**
     * Validates the notification data structure
     * @param data Map containing the notification data
     * @return Boolean indicating if the data is valid
     */
    fun validateNotificationData(data: Map<String, Any?>): Boolean {
        return try {
            // Check if at least one element is visible and has content
            val hasVisibleContent = listOf(
                "avatarVisible" to "avatarUrl",
                "nameVisible" to "nameText",
                "carrierVisible" to "carrierText",
                "numberVisible" to "numberText",
                "locationVisible" to "locationText",
                "labelsVisible" to "labelsText",
                "securityVisible" to "securityText"
            ).any { (visibleKey, textKey) ->
                val isVisible = data[visibleKey] as? Boolean ?: false
                val hasText = !((data[textKey] as? String).isNullOrEmpty())
                isVisible && hasText
            }
            
            if (!hasVisibleContent) {
                Log.w(TAG, "No visible content found in notification data")
                return false
            }
            
            true
        } catch (e: Exception) {
            Log.e(TAG, "Error validating notification data", e)
            false
        }
    }
}