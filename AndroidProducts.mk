#
# Copyright 2015 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


PRODUCT_MAKEFILES += \
        lineage_lucyzh_Natv:$(LOCAL_DIR)/s9863a1h10_Natv.mk \
        lineage_lucyzh_Tsg:$(LOCAL_DIR)/s9863a1h10_Tsg.mk \
        lineage_lucyzh_nosec:$(LOCAL_DIR)/s9863a1h10_nosec.mk \

COMMON_LUNCH_CHOICES := \
        lineage_lucyzh_Natv-userdebug \
        lineage_lucyzh_Natv-eng \
        lineage_lucyzh_Natv-user \
        lineage_lucyzh_Tsg-userdebug \
        lineage_lucyzh_Tsg-eng \
        lineage_lucyzh_Tsg-user \
        lineage_lucyzh_nosec-userdebug \
        lineage_lucyzh_nosec-eng \
        lineage_lucyzh_nosec-user \

