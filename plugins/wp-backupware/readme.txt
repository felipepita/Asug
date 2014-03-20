=== WP Backupware ===
Contributors: wpbackupware
Tags: backup, database backup, mysqldump, clone, management, restore, wp backup
Donate link: http://wpbackupware.com/donate
Requires at least: 3.8.1
Tested up to: 3.8
Stable tag: 1.2.1
License: GPLv2
License URI: http://www.gnu.org/licenses/gpl-2.0.html

WP Backupware is one of the easiest ways to backup WordPress.

== Description ==

WP Backupware is a backup plugin that has to be the easiest and most effective tool for backing up your WordPress website. The plugin is designed for use with WordPress's new design introduced in 3.8. It has the looks along with the punch. Don't take our word for it. Check it out for yourself.

The plugin is very simple to use and navigate and does not need any set up for it to work. WP Backupware creates full system backups with just one click. You can then download or remove the backup right from the dashboard. It truly does not get much more simpler than this.

= Features: =

1. Create a full or database backup.
1. Enable Daily, Weekly and Monthly backups
1. Enable if and who gets notification when a backup is created.
1. Compression of backups for easy handling.
1. *Restore and Migrate backups are in the works. As soon as the latest version is stable we will be adding the restore and migration feature

= Support =

This plugin comes with free as well as premium support (if needed). We have established a community support forum which can be used at any time.

Visit our support forums at http://wpbackupware.com/support/community-forums/

NOTE: Support requests posted at http://wordpress.org will have a delay and we can not promise will be able to respond in a timely manner. All support requests should be redirected to our support forums http://wpbackupware.com/support/community-forums/

== Installation ==
1. Install WP Backupware just like any other plugin. There is nothing special that needs to be done.
1. Activate WP Backupware through the "Plugins" menu in WordPress.
1. Visit the "Backup" link in your WordPress admin panel.
1. Click "Create Backup" and you are set.

== Frequently Asked Questions ==

= Are backups deleted if I deactivate the plugin or update WordPress = 
NO. Your backups are safe from being deleted. We do hoever encourage you to download you backups. It does not make much sense if backups are being stored on the same server that may go down.

Refer to http://wpbackupware.com/support/ for more FAQ's

= More FAQs =
Visit http://wpbackupware.com/support/ for more FAQs and other support topics.

== Upgrade Notice ==
The latest update is a complete rebuild. Please, if you find a bug; report it at the support forums.

== Screenshots ==
1. Clean Design
2. Backup List - Download - Remove

== Changelog ==

= 1.2.1 =
* Major typo fix

= 1.2.0 =
* Completely rebuild for better performance and scability
* Module based extention for flexibility and developer friendly
* Now uses wp_cron to do automated backups
* Added backup type option for automated backups. 
* Added ability to manaully create a "FULL" or "Database" backup from
* Known bug fixes

= 1.0.3 =
* Added attempt to set timeoit limit to server instead of PHP

= 1.0.2 =
* Added ignore_user_abort during backup to prevent backup from stopping during remote trigger by WPBU
* Backup noew excludes WP Backupware backup directory (save space - no sense in backups of backups)

= 1.0.1 = 
* Added confimr dialog on removal of backup
* Added notice if permalinks are not set in a manner that WPBU needs.

= 1.0.0 =
* Init build - First version submitted to WordPress for review and repo access


