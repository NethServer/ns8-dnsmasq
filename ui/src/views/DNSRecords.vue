<!--
  Copyright (C) 2023 Nethesis S.r.l.
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<template>
  <cv-grid fullWidth>
    <cv-row>
      <cv-column class="page-title">
        <h2>{{ $t("DNSrecords.title") }}</h2>
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
    <cv-row>
      <cv-column>
        <cv-tile light>
          <cv-grid class="no-padding">
            <cv-row class="toolbar">
              <cv-column>
                <NsButton
                  kind="secondary"
                  :icon="Add20"
                  @click="showCreateRouteModal"
                  >{{ $t("DNSrecords.add_dns_label") }}
                </NsButton>
              </cv-column>
            </cv-row>
            <cv-row>
              <cv-column>
                <NsDataTable
                  :allRows="filteredRoutes"
                  :columns="i18nTableColumns"
                  :rawColumns="tableColumns"
                  :sortable="true"
                  :pageSizes="[10, 25, 50, 100]"
                  :overflow-menu="true"
                  isSearchable
                  :searchPlaceholder="$t('settings_http_routes.search_route')"
                  :searchClearLabel="$t('common.clear_search')"
                  :noSearchResultsLabel="$t('common.no_search_results')"
                  :noSearchResultsDescription="
                    $t('common.no_search_results_description')
                  "
                  :isLoading="loadingRoutes"
                  :skeletonRows="5"
                  :isErrorShown="
                    !!error.listInstalledModules || !!error.listRoutes
                  "
                  :errorTitle="currentErrorAction"
                  :errorDescription="currentErrorDescription"
                  :itemsPerPageLabel="$t('pagination.items_per_page')"
                  :rangeOfTotalItemsLabel="
                    $t('pagination.range_of_total_items')
                  "
                  :ofTotalPagesLabel="$t('pagination.of_total_pages')"
                  :backwardText="$t('pagination.previous_page')"
                  :forwardText="$t('pagination.next_page')"
                  :pageNumberLabel="$t('pagination.page_number')"
                  @updatePage="tablePage = $event"
                >
                  <template slot="empty-state">
                    <NsEmptyState
                      :title="$t('settings_http_routes.no_http_route')"
                    >
                      <template #description>
                        <div>
                          {{
                            $t("settings_http_routes.no_http_route_description")
                          }}
                        </div>
                      </template>
                    </NsEmptyState>
                  </template>
                  <template slot="data">
                    <cv-data-table-row
                      v-for="(row, rowIndex) in tablePage"
                      :key="`${rowIndex}`"
                      :value="`${rowIndex}`"
                    >
                      <cv-data-table-cell>
                        <cv-link @click="showRouteDetailModal(row)">
                          {{ row.name }}
                        </cv-link>
                      </cv-data-table-cell>
                      <cv-data-table-cell>
                        <span>
                          {{ $t(`settings_http_routes.${row.type}`) }}
                        </span>
                      </cv-data-table-cell>
                      <cv-data-table-cell>
                        <span>{{ row.node }}</span>
                      </cv-data-table-cell>
                      <cv-data-table-cell class="table-overflow-menu-cell">
                        <cv-overflow-menu
                          flip-menu
                          class="table-overflow-menu"
                          :data-test-id="row.name + '-menu'"
                        >
                          <cv-overflow-menu-item
                            @click="showRouteDetailModal(row)"
                            :data-test-id="row.name + '-details'"
                          >
                            <NsMenuItem
                              :icon="ArrowRight20"
                              :label="$t('common.see_details')"
                            />
                          </cv-overflow-menu-item>
                          <cv-overflow-menu-item
                            @click="showEditRouteModal(row)"
                            :disabled="!row.user_created"
                            :data-test-id="row.name + '-edit'"
                          >
                            <NsMenuItem
                              :icon="Edit20"
                              :label="$t('common.edit')"
                            />
                          </cv-overflow-menu-item>
                          <cv-overflow-menu-item
                            danger
                            @click="showDeleteRouteModal(row)"
                            :disabled="!row.user_created"
                            :data-test-id="row.name + '-delete'"
                          >
                            <NsMenuItem
                              :icon="TrashCan20"
                              :label="$t('common.delete')"
                            />
                          </cv-overflow-menu-item>
                        </cv-overflow-menu>
                      </cv-data-table-cell>
                    </cv-data-table-row>
                  </template>
                </NsDataTable>
              </cv-column>
            </cv-row>
          </cv-grid>
        </cv-tile>
      </cv-column>
    </cv-row>
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
  name: "DNS Records",
  mixins: [
    TaskService,
    IconService,
    UtilService,
    QueryParamService,
    PageTitleService,
  ],
  pageTitle() {
    return this.$t("DNSrecords.title") + " - " + this.appName;
  },
  data() {
    return {
      q: {
        page: "dnsrecords",
      },
      urlCheckInterval: null,
      dnsrecord: [],
      loading: {
        getConfiguration: false,
        configureModule: false,
        getAvailableInterfacesBeforeConfiguration: false,
      },
      error: {
        getConfiguration: "",
        configureModule: "",
        getAvailableInterfacesBeforeConfiguration: "",
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
    this.getAvailableInterfacesBeforeConfiguration();
  },
  methods: {
    async getAvailableInterfacesBeforeConfiguration() {
      this.loading.getAvailableInterfacesBeforeConfiguration = true;
      this.error.getAvailableInterfacesBeforeConfiguration = "";
      const taskAction = "get-available-interfaces";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.getAvailableInterfacesAborted
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.getAvailableInterfacesCompleted
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
        this.error.getAvailableInterfacesBeforeConfiguration =
          this.getErrorMessage(err);
        this.loading.getAvailableInterfacesBeforeConfiguration = false;
        return;
      }
    },
    getAvailableInterfacesAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.getAvailableInterfacesBeforeConfiguration = this.$t(
        "error.generic_error"
      );
      this.loading.getAvailableInterfacesBeforeConfiguration = false;
    },
    getAvailableInterfacesCompleted(taskContext, taskResult) {
      this.loading.getAvailableInterfacesBeforeConfiguration = false;
      console.log("available ", taskResult.output.data);
      const interfaces = [];
      taskResult.output.data.forEach((iface) => {
        interfaces.push({
          name: iface,
          label: iface,
          value: iface,
        });
      });
      this.availableInterfaces = interfaces;
      this.getConfiguration();
    },
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
      this.configuration = config;

      const dhcp_server = config["dhcp-server"];
      const dns_server = config["dns-server"];

      this.interfaceField = config["interface"];
      this.DHCPEnableField = dhcp_server["enabled"];
      this.DHCPStartField = dhcp_server["start"];
      this.DHCPEndField = dhcp_server["end"];
      this.DHCPLeaseField = dhcp_server["lease"].toString();
      this.DNSEnableField = dns_server["enabled"];
      this.DNSPrimaryField = dns_server["primary-server"];
      this.DNSSecondaryField = dns_server["secondary-server"];
    },
    validateConfigureModule() {
      this.clearErrors(this);
      let isValidationOk = true;

      if (!this.interfaceField) {
        // test field cannot be empty
        this.error.interfaceField = this.$t("common.required");

        if (isValidationOk) {
          this.focusElement("interfaceField");
          isValidationOk = false;
        }
      }
      if (this.DHCPEnableField) {
        if (!this.DHCPStartField) {
          // test field cannot be empty
          this.error.DHCPStartField = this.$t("common.required");

          if (isValidationOk) {
            this.focusElement("DHCPStartField");
            isValidationOk = false;
          }
        }
        if (!this.DHCPEndField) {
          // test field cannot be empty
          this.error.DHCPEndField = this.$t("common.required");

          if (isValidationOk) {
            this.focusElement("DHCPEndField");
            isValidationOk = false;
          }
        }
        if (!this.DHCPLeaseField) {
          // test field cannot be empty
          this.error.DHCPLeaseField = this.$t("common.required");

          if (isValidationOk) {
            this.focusElement("DHCPLeaseField");
            isValidationOk = false;
          }
        }
      }
      if (this.DNSEnableField && !this.DNSPrimaryField) {
        // test field cannot be empty
        this.error.DNSPrimaryField = this.$t("common.required");

        if (isValidationOk) {
          this.focusElement("DNSPrimaryField");
          isValidationOk = false;
        }
      }

      return isValidationOk;
    },
    configureModuleValidationFailed(validationErrors) {
      this.loading.configureModule = false;
      console.log(validationErrors);

      for (const validationError of validationErrors) {
        if (validationError.field === "dhcp-server.start") {
          this.error.DHCPStartField = this.$t(
            "settings." + validationError.error
          );
        }
        if (validationError.field === "dhcp-server.end") {
          this.error.DHCPEndField = this.$t(
            "settings." + validationError.error
          );
        }
        if (validationError.field === "dhcp-server.lease") {
          this.error.DHCPLeaseField = this.$t(
            "settings." + validationError.error
          );
        }
        if (validationError.field === "dns-server.primary-server") {
          this.error.DNSPrimaryField = this.$t(
            "settings." + validationError.error
          );
        }
        if (validationError.field === "dns-server.secondary-server") {
          this.error.DNSSecondaryField = this.$t(
            "settings." + validationError.error
          );
        }
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
            interface: this.interfaceField,
            "dhcp-server": {
              enabled: this.DHCPEnableField,
              start: this.DHCPStartField,
              end: this.DHCPEndField,
              lease: parseInt(this.DHCPLeaseField),
            },
            "dns-server": {
              enabled: this.DNSEnableField,
              "primary-server": this.DNSPrimaryField,
              "secondary-server": this.DNSSecondaryField,
            },
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
