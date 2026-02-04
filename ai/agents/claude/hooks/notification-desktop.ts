#!/usr/bin/env node
import { execSync } from "child_process";

const stdin = process.stdin;
let data = "";

stdin.on("data", (chunk) => {
  data += chunk;
});

stdin.on("end", () => {
  try {
    const notification = JSON.parse(data);

    const title =
      notification.type === "permission_prompt"
        ? "Claude needs permission"
        : "Claude is waiting";

    const message = "Return to terminal to continue";

    // macOS notification using terminal-notifier
    execSync(
      `terminal-notifier -message "${message}" -title "${title}" -sound default`,
    );
  } catch (error) {
    console.error("Notification error:", error);
  }
});
