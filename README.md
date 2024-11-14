# Invisible Bots Around Player (FiveM Script)

This script spawns invisible bots around the player when they are shooting with a weapon. The bots have high health (500,000), their health is restored if they are damaged, and they don't make any sound, even when hit. The bots are automatically deleted when the player stops shooting. 

### Features:
- **Invisible Bots:** Bots spawn randomly around the player when they are shooting, remaining invisible at all times.
- **High Health:** Bots have **500,000 health** and their health is restored if they are damaged.
- **No Sound:** Bots do not make any sound, including when they are damaged or shot at.
- **Automatic Bot Deletion:** Bots are automatically deleted when the player stops shooting.

### Installation:
1. **Download** the script and place it in your `resources` folder on your FiveM server.
2. **Add** the following line to your `server.cfg`:
   ```plaintext
   ensure aimbotchecker


3. Restart your server, and the script will be active.

### How It Works:

Bot Spawning: The script spawns invisible bots around the player when they shoot. The bots spawn randomly between 3 to 7 meters around the player in different positions.

Health Restoration: If the bots are damaged by any entity (such as a player), their health will be restored to 500,000.

Bot Deletion: Once the player stops shooting, the bots will be automatically deleted after a short delay.

No Sound: The bots make no sounds, whether they are damaged, shot, or attacked in any way. This feature ensures total silence for the bots.





### Code Explanation:

spawnInvisibleBotsAroundPlayer: This function is responsible for spawning the bots around the player whenever they begin shooting. It places them at random distances and angles near the player.

checkBotHits: This function checks if the bots have been damaged by any entity. When damage is detected, the bot's health is restored to 500,000.

deleteBots: This function automatically deletes the bots when the player stops shooting. It clears the bots to prevent unnecessary performance overhead.

TaskShootCheck: This function monitors the player’s shooting activity. If the player is shooting, it triggers the bot spawning. If the player stops, the bots are deleted.



### Example Video:

In the example video provided, the bots were made visible for demonstration purposes only. In the actual script, the bots spawn as invisible, making them undetectable to the player during normal gameplay.

