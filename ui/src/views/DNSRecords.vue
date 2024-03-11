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
    <cv-row v-if="error.getDNSrecords">
      <cv-column>
        <NsInlineNotification
          kind="error"
          :title="$t('action.get-dns-records')"
          :description="error.getDNSrecords"
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
                  @click="q.isShowAddDNSRecordsModal = true"
                  >{{ $t("DNSrecords.add_dns_label") }}
                </NsButton>
              </cv-column>
            </cv-row>
            <cv-row>
              <cv-column>
                <NsDataTable
                  :allRows="dnsrecords"
                  :columns="i18nTableColumns"
                  :rawColumns="tableColumns"
                  :sortable="true"
                  :pageSizes="[10, 25, 50, 100]"
                  :overflow-menu="true"
                  isSearchable
                  :searchPlaceholder="$t('DNSrecords.search_record')"
                  :searchClearLabel="$t('common.clear_search')"
                  :noSearchResultsLabel="$t('common.no_search_results')"
                  :noSearchResultsDescription="
                    $t('common.no_search_results_description')
                  "
                  :isLoading="loading.getDNSrecords"
                  :skeletonRows="5"
                  :isErrorShown="!!error.getDNSrecords"
                  :errorTitle="error.getDNSrecords"
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
                    <NsEmptyState :title="$t('DNSrecords.no_records')">
                      <template #description>
                        <div>
                          {{ $t("DNSrecords.no_records_description") }}
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
                        <span>
                          {{ row.domain }}
                        </span>
                      </cv-data-table-cell>
                      <cv-data-table-cell>
                        <span>
                          {{ row.address }}
                        </span>
                      </cv-data-table-cell>
                      <cv-data-table-cell class="table-overflow-menu-cell">
                        <cv-overflow-menu flip-menu class="table-overflow-menu">
                          <cv-overflow-menu-item>
                            <NsMenuItem
                              :icon="Edit20"
                              :label="$t('common.edit')"
                            />
                          </cv-overflow-menu-item>
                          <NsMenuDivider />
                          <cv-overflow-menu-item danger>
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
    <NsModal
      size="default"
      :visible="q.isShowAddDNSRecordsModal"
      @modal-hidden="q.isShowAddDNSRecordsModal = false"
      @primary-click="setDNSrecords"
      :primary-button-disabled="loading.setDNSrecords"
    >
      <template slot="title">{{ $t("DNSrecords.add_dns_label") }}</template>
      <template slot="content">
        <cv-form @submit.prevent="setDNSrecords">
          <cv-text-input
            :label="$t('DNSrecords.domain')"
            v-model="domain"
            :invalid-message="$t(error.domain)"
            ref="name"
          >
          </cv-text-input>
          <cv-text-input
            :label="$t('DNSrecords.address')"
            v-model="address"
            :invalid-message="$t(error.address)"
            ref="url"
          >
          </cv-text-input>
        </cv-form>
        <NsInlineNotification
          v-if="error.setDNSrecords"
          kind="error"
          :title="$t('action.set-dns-records')"
          :description="error.setDNSrecords"
          :showCloseButton="false"
        />
      </template>
      <template slot="secondary-button">{{ $t("common.close") }}</template>
      <template slot="primary-button">{{
        $t("DNSrecords.add_dns_label")
      }}</template>
    </NsModal>
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
        isShowAddDNSRecordsModal: false,
      },
      urlCheckInterval: null,
      dnsrecords: [],
      tableColumns: ["domain", "address"],
      domain: "",
      address: "",
      loading: {
        getDNSrecords: false,
        setDNSrecords: false,
      },
      error: {
        getDNSrecords: "",
        setDNSrecords: "",
        domain: "",
        address: "",
      },
    };
  },
  computed: {
    ...mapState(["instanceName", "core", "appName"]),
    i18nTableColumns() {
      return this.tableColumns.map((column) => {
        return this.$t("DNSrecords." + column);
      });
    },
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
    this.getDNSrecords();
  },
  methods: {
    async getDNSrecords() {
      this.loading.getDNSrecords = true;
      this.error.getDNSrecords = "";
      const taskAction = "get-dns-records";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.getDNSrecordsAborted
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.getDNSrecordsCompleted
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
        this.error.getDNSrecords = this.getErrorMessage(err);
        this.loading.getDNSrecords = false;
        return;
      }
    },
    getDNSrecordsAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.getDNSrecords = this.$t("error.generic_error");
      this.loading.getDNSrecords = false;
    },
    getDNSrecordsCompleted(taskContext, taskResult) {
      this.loading.getDNSrecords = false;
      this.dnsrecords = taskResult.output.records;
      console.log("available ", taskResult.output.records);
    },
    validateDNSrecords() {
      this.clearErrors(this);
      let isValidationOk = true;

      if (!this.domain) {
        // test field cannot be empty
        this.error.domain = this.$t("common.required");

        if (isValidationOk) {
          this.focusElement("domain");
          isValidationOk = false;
        }
      }
      if (!this.address) {
        // test field cannot be empty
        this.error.address = this.$t("common.required");

        if (isValidationOk) {
          this.focusElement("address");
          isValidationOk = false;
        }
      }

      return isValidationOk;
    },
    setDNSvalidationFailed(validationErrors) {
      this.loading.setDNSrecords = false;

      for (const validationError of validationErrors) {
        if (validationError.field === "domain") {
          this.error.domain = this.$t("settings." + validationError.error);
        }
        if (validationError.field === "address") {
          this.error.address = this.$t("settings." + validationError.error);
        }
      }
    },
    async setDNSrecords() {
      const isValidationOk = this.validateDNSrecords();
      if (!isValidationOk) {
        return;
      }

      this.loading.setDNSrecords = true;
      const taskAction = "set-dns-records";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.setDNSrecordsAborted
      );

      // register to task validation
      this.core.$root.$once(
        `${taskAction}-validation-failed-${eventId}`,
        this.setDNSvalidationFailed
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.setDNSrecordsCompleted
      );

      const res = await to(
        this.createModuleTaskForApp(this.instanceName, {
          action: taskAction,
          data: {
            records: [
              ...this.dnsrecords,
              {
                domain: this.domain,
                address: this.address,
              },
            ],
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
    setDNSrecordsAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.configureModule = this.$t("error.generic_error");
      this.loading.configureModule = false;
    },
    setDNSrecordsCompleted() {
      this.loading.configureModule = false;

      // reload configuration
      this.q.isShowAddDNSRecordsModal = false;
      this.domain = "";
      this.address = "";
      this.getDNSrecords();
    },
  },
};
</script>

<style scoped lang="scss">
@import "../styles/carbon-utils";
</style>
