package com.ethiobook.epub_viewer;

import android.content.Context;
import android.graphics.Color;
import android.util.Log;

import com.folioreader.Config;
import com.folioreader.util.AppUtil;

public class ReaderConfig {
    private String identifier;
    private String themeColor;
    private String scrollDirection;
    private boolean allowSharing;
    private boolean showTts;
    private boolean nightMode;
    private boolean sepiaMode;

    public Config config;

    public ReaderConfig(Context context, String identifier, String themeColor,
                        String scrollDirection, boolean allowSharing, boolean showTts, 
                        boolean nightMode, boolean sepiaMode) {

        // Initialize the FolioReader Config
        config = new Config();

        // Set scroll direction
        if (scrollDirection.equals("vertical")) {
            config.setAllowedDirection(Config.AllowedDirection.ONLY_VERTICAL);
        } else if (scrollDirection.equals("horizontal")) {
            config.setAllowedDirection(Config.AllowedDirection.ONLY_HORIZONTAL);
        } else {
            config.setAllowedDirection(Config.AllowedDirection.VERTICAL_AND_HORIZONTAL);
        }

        // Set theme colors
        int color = Color.parseColor(themeColor);
        config.setThemeColorInt(color); // Day mode color
        config.setNightThemeColorInt(color); // Night mode color

        // Set sepia mode
        if (sepiaMode) {
            config.setThemeColorInt(Color.parseColor("#F4ECD8")); // Sepia background color
            config.setNightThemeColorInt(Color.parseColor("#5E462B")); // Sepia text color
        }

        // Set other configurations
        config.setShowRemainingIndicator(true);
        config.setShowTts(showTts);
        config.setNightMode(nightMode);
    }
}