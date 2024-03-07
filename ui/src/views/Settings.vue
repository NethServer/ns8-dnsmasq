<!--
  Copyright (C) 2023 Nethesis S.r.l.
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<template>
  <cv-grid fullWidth>
    <cv-row>
      <cv-column class="page-title">
        <h2>{{ $t("settings.title") }}</h2>
      </cv-column>
    </cv-row>
    <cv-row v-if="error.getConfiguration">
      <cv-column>
        <NsInlineNotification
          kind="error"
          :title="$t('action.get-configuration')"
          :description="error.getConfiguration"
          :showCloseButton="false"
        />
      </cv-column>
    </cv-row>
    <cv-row>
      <cv-column>
        <cv-tile light>
          <cv-form @submit.prevent="configureModule">
            <cv-combo-box
              v-model="interfaceField"
              :title="$t('settings.interface_label')"
              :label="$t('settings.interface_placeholder')"
              :invalid-message="error.interfaceField"
              :auto-filter="true"
              :auto-highlight="true"
              :options="availableInterfaces"
              :disabled="
                loading.getConfiguration ||
                loading.configureModule ||
                loading.getAvailableInterfaces
              "
              ref="interfaceField"
            >
            </cv-combo-box>
            <cv-row v-if="error.configureModule">
              <cv-column>
                <NsInlineNotification
                  kind="error"
                  :title="$t('action.configure-module')"
                  :description="error.configureModule"
                  :showCloseButton="false"
                />
              </cv-column>
            </cv-row>
            <NsButton
              kind="primary"
              :icon="Save20"
              :loading="loading.configureModule"
              :disabled="loading.getConfiguration || loading.configureModule"
              >{{ $t("settings.save") }}</NsButton
            >
          </cv-form>
        </cv-tile>
      </cv-column>
    </cv-row>
    <div v-if="!interfaceField">
      <cv-row>
        <cv-column>
          <cv-tile light>
            <cv-form @submit.prevent="configureModule">
              <h4>DHCP</h4>
              <div class="title-description mg-bottom-xlg">
                {{ $t("settings.DHCP_description") }}
              </div>
              <NsToggle
                :label="$t('settings.DHCP_enable_label')"
                v-model="DHCPEnableField"
                value="DHCPEnableField"
                formItem
                ref="DHCPEnableField"
              >
                <template slot="text-left">{{
                  $t("settings.disabled")
                }}</template>
                <template slot="text-right">{{
                  $t("settings.enabled")
                }}</template>
              </NsToggle>
              <div v-if="DHCPEnableField">
                <cv-text-input
                  :label="$t('settings.DHCP_start_label')"
                  v-model="DHCPStartField"
                  :disabled="
                    loading.getConfiguration || loading.configureModule
                  "
                  :invalid-message="error.DHCPStartField"
                  ref="DHCPStartField"
                ></cv-text-input>
                <cv-text-input
                  :label="$t('settings.DHCP_end_label')"
                  v-model="DHCPEndField"
                  :disabled="
                    loading.getConfiguration || loading.configureModule
                  "
                  :invalid-message="error.DHCPEndField"
                  ref="DHCPEndField"
                ></cv-text-input>
                <cv-text-input
                  :label="$t('settings.DHCP_lease_label')"
                  :helper-text="$t('settings.DHCP_lease_hint')"
                  v-model="DHCPLeaseField"
                  :disabled="
                    loading.getConfiguration || loading.configureModule
                  "
                  :invalid-message="error.DHCPLeaseField"
                  ref="DHCPLeaseField"
                >
                </cv-text-input>
              </div>
              <cv-row v-if="error.configureModule">
                <cv-column>
                  <NsInlineNotification
                    kind="error"
                    :title="$t('action.configure-module')"
                    :description="error.configureModule"
                    :showCloseButton="false"
                  />
                </cv-column>
              </cv-row>
              <NsButton
                kind="secondary"
                :icon="Save20"
                :loading="loading.configureModule"
                :disabled="loading.getConfiguration || loading.configureModule"
                >{{ $t("settings.save") }}</NsButton
              >
            </cv-form>
          </cv-tile>
        </cv-column>
      </cv-row>
      <cv-row>
        <cv-column>
          <cv-tile light>
            <cv-form @submit.prevent="configureModule">
              <h4>DNS</h4>
              <div class="title-description mg-bottom-xlg">
                {{ $t("settings.DNS_description") }}
              </div>
              <NsToggle
                :label="$t('settings.DNS_enable_label')"
                v-model="DNSEnableField"
                value="DNSEnableField"
                formItem
                ref="DNSEnableField"
              >
                <template slot="text-left">{{
                  $t("settings.disabled")
                }}</template>
                <template slot="text-right">{{
                  $t("settings.enabled")
                }}</template>
              </NsToggle>
              <div v-if="DNSEnableField">
                <cv-text-input
                  :label="$t('settings.DNS_primary_label')"
                  v-model="DNSPrimaryField"
                  :disabled="
                    loading.getConfiguration || loading.configureModule
                  "
                  :invalid-message="error.DNSPrimaryField"
                  ref="DNSPrimaryField"
                ></cv-text-input>
                <cv-text-input
                  :label="$t('settings.DNS_secondary_label')"
                  v-model="DNSSecondaryField"
                  :disabled="
                    loading.getConfiguration || loading.configureModule
                  "
                  :invalid-message="error.DNSSecondaryField"
                  ref="DNSSecondaryField"
                ></cv-text-input>
              </div>
              <cv-row v-if="error.configureModule">
                <cv-column>
                  <NsInlineNotification
                    kind="error"
                    :title="$t('action.configure-module')"
                    :description="error.configureModule"
                    :showCloseButton="false"
                  />
                </cv-column>
              </cv-row>
              <NsButton
                kind="secondary"
                :icon="Save20"
                :loading="loading.configureModule"
                :disabled="loading.getConfiguration || loading.configureModule"
                >{{ $t("settings.save") }}</NsButton
              >
            </cv-form>
          </cv-tile>
        </cv-column>
      </cv-row>
    </div>
  </cv-grid>
</template>

<script>
import to from "await-to-js";
import { mapState } from "vuex";
import {
  QueryParamService,
  UtilService,
  TaskService,
  IconService,
  PageTitleService,
} from "@nethserver/ns8-ui-lib";

export default {
  name: "Settings",
  mixins: [
    TaskService,
    IconService,
    UtilService,
    QueryParamService,
    PageTitleService,
  ],
  pageTitle() {
    return this.$t("settings.title") + " - " + this.appName;
  },
  data() {
    return {
      q: {
        page: "settings",
      },
      urlCheckInterval: null,
      configuration: {},
      availableInterfaces: [],
      configure: {},
      interfaceField: "",
      DHCPEnableField: false,
      DHCPStartField: "",
      DHCPEndField: "",
      DHCPLeaseField: 0,
      DNSEnableField: false,
      DNSPrimaryField: "",
      DNSSecondaryField: "",
      loading: {
        getConfiguration: false,
        configureModule: false,
        getAvailableInterfaces: false,
      },
      error: {
        getConfiguration: "",
        configureModule: "",
        getAvailableInterfaces: "",
        interfaceField: "",
        DHCPEnableField: "",
        DHCPStartField: "",
        DHCPEndField: "",
        DHCPLeaseField: "",
        DNSEnableField: "",
        DNSPrimaryField: "",
        DNSSecondaryField: "",
      },
    };
  },
  computed: {
    ...mapState(["instanceName", "core", "appName"]),
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      vm.watchQueryData(vm);
      vm.urlCheckInterval = vm.initUrlBindingForApp(vm, vm.q.page);
    });
  },
  beforeRouteLeave(to, from, next) {
    clearInterval(this.urlCheckInterval);
    next();
  },
  created() {
    this.getConfiguration();
  },
  methods: {
    async getConfiguration() {
      this.loading.getConfiguration = true;
      this.error.getConfiguration = "";
      const taskAction = "get-configuration";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.getConfigurationAborted
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.getConfigurationCompleted
      );

      const res = await to(
        this.createModuleTaskForApp(this.instanceName, {
          action: taskAction,
          extra: {
            title: this.$t("action." + taskAction),
            isNotificationHidden: true,
            eventId,
          },
        })
      );
      const err = res[0];

      if (err) {
        console.error(`error creating task ${taskAction}`, err);
        this.error.getConfiguration = this.getErrorMessage(err);
        this.loading.getConfiguration = false;
        return;
      }
    },
    getConfigurationAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.getConfiguration = this.$t("error.generic_error");
      this.loading.getConfiguration = false;
    },
    getConfigurationCompleted(taskContext, taskResult) {
      this.loading.getConfiguration = false;
      const config = taskResult.output;

      // TODO set configuration fields
      // ...
      this.console // TODO remove
        .log("config", config);

      this.focusElement("interfaceField");
    },
    validateConfigureModule() {
      this.clearErrors(this);
      let isValidationOk = true;

      // TODO remove interfaceField and validate configuration fields
      if (!this.interfaceField) {
        // test field cannot be empty
        this.error.interfaceField = this.$t("common.required");

        if (isValidationOk) {
          this.focusElement("interfaceField");
          isValidationOk = false;
        }
      }
      return isValidationOk;
    },
    configureModuleValidationFailed(validationErrors) {
      this.loading.configureModule = false;

      for (const validationError of validationErrors) {
        const param = validationError.parameter;

        // set i18n error message
        this.error[param] = this.$t("settings." + validationError.error);
      }
    },
    async configureModule() {
      const isValidationOk = this.validateConfigureModule();
      if (!isValidationOk) {
        return;
      }

      this.loading.configureModule = true;
      const taskAction = "configure-module";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.configureModuleAborted
      );

      // register to task validation
      this.core.$root.$once(
        `${taskAction}-validation-failed-${eventId}`,
        this.configureModuleValidationFailed
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.configureModuleCompleted
      );

      const res = await to(
        this.createModuleTaskForApp(this.instanceName, {
          action: taskAction,
          data: {
            // TODO configuration fields
          },
          extra: {
            title: this.$t("settings.configure_instance", {
              instance: this.instanceName,
            }),
            description: this.$t("common.processing"),
            eventId,
          },
        })
      );
      const err = res[0];

      if (err) {
        console.error(`error creating task ${taskAction}`, err);
        this.error.configureModule = this.getErrorMessage(err);
        this.loading.configureModule = false;
        return;
      }
    },
    configureModuleAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.configureModule = this.$t("error.generic_error");
      this.loading.configureModule = false;
    },
    configureModuleCompleted() {
      this.loading.configureModule = false;

      // reload configuration
      this.getConfiguration();
    },
  },
};
</script>

<style scoped lang="scss">
@import "../styles/carbon-utils";
</style>
