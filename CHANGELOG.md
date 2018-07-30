# Changelog

## 0.10.22 - 2018-04-06

* YAD-168 User can generate full report or individual participant report (#168)

## 0.10.21 - 2018-04-03

* YAD-167 patch loofah and rails-html-sanitizer (#166)

## 0.10.20 - 2018-03-07

* Update rails_admin, update type comparison in report generator (#164)
* YAD-163 A user can export participant data easily (#163)
* YAD-159 Moved congratulatory message to home screen (#162)

## 0.10.19 - 2018-02-23

* YAD-164 apply security patches (#160)

## 0.10.18 - 2017-11-17

* YAD-161 Allow multiple valid access tokens (#158)

## 0.10.17 - 2017-10-30

* YAD-150 Participants only need to view modules they scored less than benchmark on baseline (#152)
* JN -YAD-153 Order assessment answers by position field (#156)

## 0.10.16 - 2017-10-27

* YAD-154 add congratulations (#154)
* YAD-152 Change text of Final Assessment Welcome Page (#153)
* YAD-149 Add button to module page and standardize buttons throughout (#151)

## 0.10.15 - 2017-10-13

* YAD-140 center home button on report cards (#149)

## 0.10.14 - 2017-10-11

* YAD-140: Added link back to home after report cards. (#145)
* YAD-142 Change file type to .mvs (#147)
* YAD-136: Changes to Baseline Assessment instructions (#146)

## 0.10.13 - 2017-10-06

* YAD-135 Elaborate on home page instructions (#143)
* YAD-127 YAD-128 YAD-129 YAD-132 How-to page and superscript edits (#142)

## 0.10.12 - 2017-09-27

* Update nokogiri gem (#140)

## 0.10.11 - 2017-09-15

* YAD-115 Create monthly reminders for users (#135)

## 0.10.10 - 2017-09-15

* YAD-126 add a link to the video on how-to page (#137)
* YAD-123 changed from email address to 'esophageal.quality@gmail.com' (#132)
* YAD-125 update session time out (#136)
* YAD-122 add link to report card for final assessment (#134)
* YAD-124 add participant's info to raven (#133)
* YAD-120: User score and expected score was highlighted for both baseline and final report cards. (#130)

## 0.10.9 - 2017-09-11

* Filled text for the final assessments. (#127)
* YAD-113: Filled in text for the landing page for the baseline assessments. (#125)
* YAD-121 Participant must view report card at end of baseline assessment (#129)
* YAD-116 Change text on module download button (#128)
* YAD-111 Add text to how to page (#126)
* YAD-105 Add consent page text (#124)

## 0.10.8 - 2017-08-31

* YAD-98 update rails admin setup (#122)
* YAD-98 YAD-99 Update rails_admin config (#118)

## 0.10.7 - 2017-08-29

* YAD-98 YAD-99 Update rails_admin config (#118)

## 0.10.6 - 2017-08-29

* Updated Final Report card w/ benchmarks (#115)
* YAD-101 red module turns green when completed (#116)

## 0.10.5 - 2017-08-24

* YAD-83 rename title column in Story in migration (#113)

## 0.10.4 - 2017-08-23

* YAD-83 module highlight low score (#111)

## 0.10.3 - 2017-08-22

* install factory girl gem for all groups (#109)
* YAD-79 YAD-86 update logic to detect whether ... (#107)

## 0.10.2 - 2017-08-22

* YAD-90 update final report card title (#106)
* YAD-78 prevent participants from accessing ... (#105)
* YAD-89 fix render method call (#104)
* YAD-62 combine baseline and final tables (#103)
* YAD-61 add % to benchmark scores (#102)
* YAD-70 add correct baseline answers (#99)

## 0.10.1 - 2017-08-18

* YAD-84 completed module is highlighted green (#100)
* YAD-87 fix baseline report card rendering (#98)
* YAD-79 require responses for baseline assessments (#96)

## 0.10.0 - 2017-08-18

* YAD-75 change ModuleFiles to use .mvs (#95)
* YAD-60 YAD-61 YAD-68 YAD-69 YAD-80 (#94)
* YAD-73 permit .mvs files for CaseFile upload (#93)
* YAD-57 deny access for Participants after 3 months (#92)
* YAD-85 allow Answers to be associated with Cases (#91)
* YAD-72 (#90)
* YAD-66 add new modules and update README (#89)
* YAD-82 Changed text of header in baseline report card (#88)
* YAD-82 altered second column label on Baseline Assessment Score page (#87)
* YAD-77 removed Baseline welcome subheading (#86)

## 0.9.2 - 2017-08-11

* YAD-59 take different approach to email pdf (#84)

## 0.9.1 - 2017-08-10

* YAD-59 ensure email address is used (#82)

## 0.9.0 - 2017-08-10

* YAD-59 make report PDF available to view or email (#80)
* YAD-62 add final report card (#79)
* add rake task to create admin account (#78)
* YAD-60 display baseline assessment percent correct (#77)
* perform more housekeeping (#76)
* YAD-60 normalize assessment answers (#75)
* YAD-58 update Save button labels (#74)
* update gems; add version API (#73)
* perform housekeeping (#72)
* Tag new release. (0.8.1) (#71)

## 0.8.1 - 2017-07-10
 * YAD-56 redirect unrecognized requests (#70)
 * Tag new release. (0.8.0) (#69)

## 0.8.0 - 2017-06-30
 * YAD-53 Add Exit functionality (#68)
 * YAD-53 Add Assessment State (#67)
 * YAD-54 Change Consent (#65)
 * YAD-51 Module View Update (#66)
 * YAD-52 Add Intro (#64)
 * YAD-50 Method on Nil (#62)
 * YAD-55 Add Congratulation Pages (#63)
 * Tag new release. (0.7.2) (#61)

## 0.7.2 - 2017-06-21
 * YAD-46 Hide Modules Link (#60)
 * YAD-44 Update PIP (#59)
 * Tag new release. (0.7.1) (#58)

## 0.7.1 - 2017-06-07
 * YAD-48 make module download robust in edge cases (#57)
 * YAD-48 provide empty session for invalid token (#56)
 * YAD-49 auto-set User password (#55)
 * Tag new release. (0.7.0) (#54)

## 0.7.0 - 2017-05-19
 * Msw yad 42 incorporate modules (#53)
 * Tag new release. (0.6.0) (#51)

## 0.6.0 - 2017-05-17
 * YAD-41 Add account link and spec (#50)
 * Tag new release. (0.5.1) (#49)
 * YAD-15 Remove Turbolinks from Module link (#47)
 * Tag new release. (0.5.0) (#46)

## 0.5.1 - 2017-05-16
  * Remove Turbolinks from Module link (#47)

## 0.5.0 - 2017-05-16
 * Update Ruby Version (#41)

## 0.4.0 - 2017-05-15
 * YAD-25 YAD-32 YAD-36 (#45)
 * Video Integration (#43)
 * YAD-37 Update Redirects (#42)
 * YAD-38 Notifications only sent to active participants (#40)

## 0.3.1 - 2017-05-01
 * YAD-39 Remove nil from receives_notification (#39)

## 0.3.0 - 2017-05-01
 * YAD-27 YAD-28 YAD-38 Track notifications (#38)
 * Update gems (#37)
 * YAD-28 YAD-38 Reminder notifications to participants (#36)

## 0.2.5 - 2017-04-27
 * Move module files to public/system so they don't get overwritten (#35)

## 0.2.4 - 2017-04-27
 * YAD-24 Add zip mime-type (#34)

## 0.2.3 - 2017-04-27
 * YAD-24 Module files should be downloadable (#33)
 * YAD-22 Case information should be downloadable (#32)

## 0.2.2 - 2017-04-26
 * YAD-33 YAD-34 Add task to copy font-awesome assets (#31)

## 0.2.1 - 2017-04-25
 * YAD-33 YAD-34 Change font-awesome gem, add jquery (#30)
 * Tag new release. (0.2.0) (#29)

## 0.2.0 - 2017-04-25
 * Merge pull request #27 from NU-CBITS/msw_YAD-18
 * YAD-18
 * Merge pull request #28 from NU-CBITS/msw_YAD-19_add_access_token2
 * YAD-19 Add Access Token
 * Merge pull request #26 from NU-CBITS/msw_update_readme
 * Update README
 * Merge pull request #25 from NU-CBITS/cjb-consent-update
 * YAD-14 Update consent
 * Merge pull request #24 from NU-CBITS/awa-YAD-27
 * YAD-27 Add notification schedule model
 * Merge pull request #23 from NU-CBITS/awa-YAD-21
 * Add bullet
 * Merge pull request #22 from NU-CBITS/cjb-rails-admin-conf
 * Configure rails_admin for feedback models
 * Merge pull request #21 from NU-CBITS/cjb-0.1.2

## 0.1.2 - 2017-04-18
 * Merge pull request #20 from NU-CBITS/cjb-mailer-addresses
 * Update addresses for mailers
 * Merge pull request #19 from NU-CBITS/cjb-0.1.1

## 0.1.1 - 2017-04-18
 * Merge pull request #18 from NU-CBITS/cjb-schedule.rb
 * Add schedule.rb so app can be deployed
 * Merge pull request #17 from NU-CBITS/cjb-0.1.0

## 0.1.0 - 2017-04-18
 * Initial release
