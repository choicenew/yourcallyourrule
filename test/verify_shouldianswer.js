// verify_shouldianswer.js
// This script simulates the extraction logic used in the plugin.
// It is designed to be run in a JS environment (Browser Console, Node, or Plugin Loader)
// to verify that the Regex correctly extracts data from the ShouldIAnswer HTML.

(function() {
    console.log("--- Starting ShouldIAnswer Regex Verification ---");

    // 1. The Target HTML (Simulated from actual fetch)
    // This is a snippet from the actual page for 2026307992
    const htmlContent = `
    <!DOCTYPE html>
    <html lang='en'>
    <head>
      <title>Who called you from 2026307992 (+12026307992) ? | shouldianswer.com</title>
      <meta name="description" content="Read more than 1 user reviews and security ratings for number 2026307992 / +1 202-630-7992 (fixed or mobile line, United States, District Of Columbia), mostly rated as negative Unsolicited call. Get our Free protection against unwanted calls.">
    </head>
    <body>
       <div class="main_summary_red">Negative</div>
       <div class="reviews">
          <div class="review">Unsolicited call reported by SIA User</div>
       </div>
    </body>
    </html>
    `;

    console.log("HTML Content Length: " + htmlContent.length);

    // 2. The Regex to Test
    // We want to extract 'negative Unsolicited call' or just 'Negative'
    // Pattern A: From meta description (preferred for this site as it summarizes)
    const regexMeta = /rated as ([^.]+)/;
    
    // Pattern B: From summary div
    const regexDiv = /class="main_summary_[^"]*"\s*>([^<]+)/;

    // 3. Execution
    console.log("Testing Regex A (Meta Description): " + regexMeta.toString());
    const matchA = htmlContent.match(regexMeta);
    if (matchA && matchA[1]) {
        console.log("✅ Match A Success: '" + matchA[1].trim() + "'");
    } else {
        console.log("❌ Match A Failed");
    }

    console.log("Testing Regex B (Summary Div): " + regexDiv.toString());
    const matchB = htmlContent.match(regexDiv);
    if (matchB && matchB[1]) {
        console.log("✅ Match B Success: '" + matchB[1].trim() + "'");
    } else {
        console.log("❌ Match B Failed");
    }

    console.log("--- Verification Complete ---");
})();
