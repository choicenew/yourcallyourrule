# YourCallYourRule: Your Calls, Your Rules
[中文版本](https://github.com/choicenew/yourcallyourrule/blob/main/READMECN.md)
**YourCallYourRule** is a powerful and highly customizable Android application designed to give you complete control over your incoming calls. You can create personalized blocking rules based on phone numbers, keywords, and more.

- **Telegram Channel:** https://t.me/yourcallyourrule
- **Telegram Group:** https://t.me/+GHoPy6xwQEU1ZThh
- **Google Play (Beta):** https://play.google.com/apps/testing/com.yours.yourcallyourrule
- **Google Play (Stable):** https://play.google.com/store/apps/details?id=com.yours.yourcallyourrule

> **Note**: You can also download the appropriate version from this repository's [Releases](https://github.com/choicenew/yourcallrule/releases) page. 

> **NEW Plugin Repo**: The new plugins are now supported by a new developer. You can also download version from this repository's [New Developer](https://github.com/ngodeel/yourcallrule) page.
## Core Features

*   **Blacklist & Whitelist Management**: Easily create lists of allowed and blocked numbers.
*   **Rule Import/Export**: Conveniently back up and share your rule sets.
*   **Online Rule Subscription**: Subscribe to curated blocklists using a subscription URL.
*   **Regular Expression Support**: Define complex and powerful blocking rules.
*   **STIR/SHAKEN Integration**: Leverage STIR/SHAKEN technology for enhanced caller ID verification (supported in select regions, including North America).
*   **SIM Card Recognition**: Apply different rules based on which SIM card is receiving the call.
*   **Flexible Blocking Actions**: Choose to hang up, mute, or answer-and-hang-up blocked calls.
*   **Privacy & Data Control**: All data is managed locally on your device. The app does not include a built-in online database, ensuring your privacy.
*   **Cloud Backup & Restore**: Supports WebDAV, Google Drive, and OneDrive for seamless backup and restoration of your settings.

## Plugin System

One of the core strengths of `YourCallYourRule` is its powerful plugin system, which allows you to identify unknown numbers by scraping data from websites.

*   **Plugin Directory**: All official and community-contributed plugins are located in the `/plugins` directory of this repository.
*   **Template File**: Inside the `/plugins` directory, you'll find a `template.js` file. You can use this as a starting point to develop your own plugins.
*   **Update Status**: Please note that only the plugins located directly in the `/plugins` directory are currently maintained and up-to-date.

### How to Create Your Own Plugin

Creating a plugin is easier than you might think, even without a background in programming:

1.  Open your desired data source website (e.g., any reverse phone lookup site) in your browser.
2.  Open the browser's Developer Tools (usually `Ctrl`+`Shift`+`I`) and copy the page's HTML source code.
3.  Provide the **HTML source code**, the **`template.js` file** from the `/plugins` directory, and **any existing plugin file as an example** to an AI (like ChatGPT, Gemini, etc.).
4.  Instruct the AI: "Please create a plugin to parse phone number information from this HTML source code, using this template and referencing this example."

The AI can typically understand the request and generate the necessary plugin code for you.

## Contributing & Support

We welcome and encourage community contributions to the project.

*   **Submit/Update/Fix Plugins**: If you create/fix/update a plugin, please share it with the community by submitting a Pull Request.
*   **Report Issues**: Use the [Issues](https://github.com/choicenew/yourcallrule/issues) tab to report bugs or suggest new features.
*   **Internationalization (i18n)**: The app's interface translations are primarily done by AI and may contain inaccuracies. We welcome contributions to improve them.
    *   **Translation Workflow**: The project uses an `l10n.yaml` file with Firebase Studio for translating ARB files. You can set this up in any new Flutter project by placing the `tool/translate.dart` file in the appropriate directory and configuring the API.

## Disclaimer

*   **Development Status**: This application is maintained by a single developer in their spare time, so updates may be irregular.
*   **Data Sources**: The app does not come with a built-in number database. All data must be provided by the user through subscription links or custom plugins.
