## Reconnaissance Report (2025-12-18T02:59:51.621Z)

### 1. Endpoint Profile (21 unique paths)
| Count | Methods | Path |
|---|---|---|
| 73 | POST | `/meerkat-reporter/api/report` |
| 50 | POST | `/v4/api/multimodal/video/processing` |
| 6 | GET | `/v1/api/multimodal/preset/tags` |
| 6 | GET | `/v1/api/charge/upgrade_guide` |
| 4 | GET | `/v3/api/multimodal/video/my/batchCursor` |
| 4 | GET | `/v1/api/charge/monthly_gift_eligible` |
| 4 | GET | `/v1/api/user/equity` |
| 4 | GET | `/public/v1/api/user/model` |
| 4 | POST | `/v1/api/multimodal/task/read` |
| 4 | POST | `/v2/api/multimodal/video/delete` |
| 2 | GET | `/public/api/config/web/common_config` |
| 2 | GET | `/public/api/config/web/seo_config` |
| 2 | POST | `/v1/api/user/device/register` |
| 2 | GET | `/v1/api/charge/report/info` |
| 2 | GET | `/v2/api/multimodal/video/character/list` |
| 2 | POST | `/v1/api/files/get_user_image_by_type` |
| 2 | GET | `/v1/api/charge/combo/get_old_combo_v2` |
| 2 | GET | `/public/api/charge/banner` |
| 2 | GET | `/public/v1/api/user/new_user_credit` |
| 2 | POST | `/v1/api/multimodal/generate/image` |
| 1 | POST | `/v1/accounts:lookup` |

### 2. Discovered Keys of Interest
* `statusInfo`
* `userID`
* `realUserID`
* `tabKeys`
* `contentKey`
* `titleKey`
* `enable_payment_user_ids`
* `free_credits_text`
* `white_list_user_ids`
* `newGuideTagKey`
* `newGuideTagKey_preview`
* `promotion_event`
* `promotional_price_text`
* `showToUserType`
* `creditPayBonusMonthly`
* `uploadUserWhiteList`
* `key`
* `totalCredits`
* `isNewUser`
* `newUserVersion`
* `creditExpireText`
* `credit`
* `creditStr`
* `totalCreditsStr`
* `isPaidSubscription`
* `debitCredit`
* `status`
* `postStatus`
* `humanCheckStatus`
* `userIDStr`
* `projectStatus`
* `author`
* `idToken`
* `task`

### 3. Observed Engagement Flow (Chronological)

**Flow #1: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: GET to `/public/v1/api/user/new_user_credit` (request)
  - Step 2: GET to `/v1/api/charge/upgrade_guide` (request)
  - Step 3: POST to `/meerkat-reporter/api/report` (response)
  - Step 4: POST to `/meerkat-reporter/api/report` (response)
  - Step 5: POST to `/meerkat-reporter/api/report` (response)
  - Step 6: POST to `/meerkat-reporter/api/report` (response)
  - Step 7: POST to `/meerkat-reporter/api/report` (response)
  - Step 8: POST to `/meerkat-reporter/api/report` (response)
  - Step 9: POST to `/meerkat-reporter/api/report` (response)

**Flow #2: Action triggered by POST to `/v1/api/multimodal/generate/image`**
  - Step 1: POST to `/meerkat-reporter/api/report` (response)
  - Step 2: POST to `/meerkat-reporter/api/report` (response)
  - Step 3: POST to `/v1/api/multimodal/generate/image` (response)
  - Step 4: POST to `/meerkat-reporter/api/report` (request)
  - Step 5: GET to `/v3/api/multimodal/video/my/batchCursor` (request)
  - Step 6: GET to `/v1/api/charge/monthly_gift_eligible` (request)
  - Step 7: GET to `/v1/api/user/equity` (request)
  - Step 8: GET to `/public/v1/api/user/model` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (request)

**Flow #3: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: GET to `/v1/api/charge/upgrade_guide` (request)
  - Step 2: POST to `/meerkat-reporter/api/report` (response)
  - Step 3: GET to `/v3/api/multimodal/video/my/batchCursor` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: GET to `/v1/api/charge/monthly_gift_eligible` (response)
  - Step 6: GET to `/v1/api/user/equity` (response)
  - Step 7: GET to `/v1/api/charge/upgrade_guide` (request)
  - Step 8: GET to `/public/v1/api/user/model` (response)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #4: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: GET to `/v1/api/charge/monthly_gift_eligible` (response)
  - Step 2: GET to `/v1/api/user/equity` (response)
  - Step 3: GET to `/v1/api/charge/upgrade_guide` (request)
  - Step 4: GET to `/public/v1/api/user/model` (response)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/meerkat-reporter/api/report` (request)
  - Step 7: POST to `/v1/api/multimodal/task/read` (request)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: GET to `/v1/api/charge/upgrade_guide` (response)

**Flow #5: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: GET to `/v1/api/charge/upgrade_guide` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 3: POST to `/v1/api/multimodal/task/read` (request)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: GET to `/v1/api/charge/upgrade_guide` (response)
  - Step 6: POST to `/meerkat-reporter/api/report` (response)
  - Step 7: POST to `/v1/api/multimodal/task/read` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 9: POST to `/v1/api/multimodal/task/read` (response)

**Flow #6: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: GET to `/v1/api/charge/upgrade_guide` (response)
  - Step 2: POST to `/meerkat-reporter/api/report` (response)
  - Step 3: POST to `/v1/api/multimodal/task/read` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 5: POST to `/v1/api/multimodal/task/read` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (request)

**Flow #7: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #8: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #9: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #10: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #11: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #12: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #13: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/meerkat-reporter/api/report` (request)
  - Step 9: POST to `/meerkat-reporter/api/report` (response)

**Flow #14: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/meerkat-reporter/api/report` (request)
  - Step 7: POST to `/meerkat-reporter/api/report` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #15: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/meerkat-reporter/api/report` (request)
  - Step 5: POST to `/meerkat-reporter/api/report` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (response)

**Flow #16: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/meerkat-reporter/api/report` (request)
  - Step 3: POST to `/meerkat-reporter/api/report` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/meerkat-reporter/api/report` (request)
  - Step 9: POST to `/meerkat-reporter/api/report` (request)

**Flow #17: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/meerkat-reporter/api/report` (request)
  - Step 5: POST to `/meerkat-reporter/api/report` (request)
  - Step 6: POST to `/v2/api/multimodal/video/delete` (request)
  - Step 7: POST to `/meerkat-reporter/api/report` (response)
  - Step 8: POST to `/meerkat-reporter/api/report` (request)
  - Step 9: POST to `/meerkat-reporter/api/report` (response)

**Flow #18: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/meerkat-reporter/api/report` (request)
  - Step 3: POST to `/meerkat-reporter/api/report` (request)
  - Step 4: POST to `/v2/api/multimodal/video/delete` (request)
  - Step 5: POST to `/meerkat-reporter/api/report` (response)
  - Step 6: POST to `/meerkat-reporter/api/report` (request)
  - Step 7: POST to `/meerkat-reporter/api/report` (response)
  - Step 8: POST to `/v2/api/multimodal/video/delete` (response)
  - Step 9: POST to `/meerkat-reporter/api/report` (request)

**Flow #19: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/meerkat-reporter/api/report` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/meerkat-reporter/api/report` (request)
  - Step 4: POST to `/meerkat-reporter/api/report` (response)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 7: POST to `/meerkat-reporter/api/report` (request)
  - Step 8: POST to `/meerkat-reporter/api/report` (request)
  - Step 9: POST to `/v2/api/multimodal/video/delete` (request)

**Flow #20: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/meerkat-reporter/api/report` (request)
  - Step 2: POST to `/meerkat-reporter/api/report` (response)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 5: POST to `/meerkat-reporter/api/report` (request)
  - Step 6: POST to `/meerkat-reporter/api/report` (request)
  - Step 7: POST to `/v2/api/multimodal/video/delete` (request)
  - Step 8: POST to `/meerkat-reporter/api/report` (request)
  - Step 9: POST to `/meerkat-reporter/api/report` (request)

**Flow #21: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/meerkat-reporter/api/report` (response)
  - Step 2: POST to `/meerkat-reporter/api/report` (response)
  - Step 3: POST to `/v2/api/multimodal/video/delete` (response)
  - Step 4: POST to `/meerkat-reporter/api/report` (response)
  - Step 5: POST to `/meerkat-reporter/api/report` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (request)

**Flow #22: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 8: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 9: POST to `/v4/api/multimodal/video/processing` (request)

**Flow #23: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 7: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 8: POST to `/meerkat-reporter/api/report` (request)

**Flow #24: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 5: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 6: POST to `/meerkat-reporter/api/report` (request)

**Flow #25: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/v4/api/multimodal/video/processing` (request)
  - Step 3: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 4: POST to `/meerkat-reporter/api/report` (request)

**Flow #26: Action triggered by POST to `/v4/api/multimodal/video/processing`**
  - Step 1: POST to `/v4/api/multimodal/video/processing` (response)
  - Step 2: POST to `/meerkat-reporter/api/report` (request)
