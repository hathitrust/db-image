# frozen_string_literal: true

require "database"

module HathiTrust
  class DatabaseSchema
    # Not including `ht`
    ALL_DATABASES = [
      :hathifiles,
      :ht_maintenance,
      :ht_repository,
      :ht_rights,
      :ht_web
    ]

    attr_reader :db

    def initialize
      @db = Database.new
    end

    # This should only ever return zero or one database.
    # It's a problem if we have ambiguous sources.
    def ht_table_source(table)
      [].tap do |sources|
        Database::ALL_DATABASES.each do |database|
          const_name = "HathiTrust::DatabaseSchema::" + database.to_s.upcase + "_TABLES"
          database_tables = Object.const_get(const_name)
          if database_tables.include?(table.to_sym)
            sources << database
            next
          end
        end
      end
    end
    
    # Must pass the actual database, not ht if it is a view
    def count_rows(database:, table:)
      sql = <<~SQL
      SELECT TABLE_ROWS FROM information_schema.tables
      WHERE table_schema=? AND table_name=?
      SQL
      result = db.connection[sql, database.to_s, table.to_s].first
      #puts "count_rows(#{database}, #{table}) => #{result}"
      result = result[:TABLE_ROWS] unless result.nil?
      result
    end

    # These are not tables that can be dumped.
    # Should be a way to dump the CREATE VIEW but for now we can do without.
    HT_VIEWS = [
      :ddd,
      :collection_names,
      :feed_last_error
    ].freeze

    HT_TABLES = [
      :access_profiles,
      :access_stmts,
      :access_stmts_map,
      :attributes,
      :dataset_blacklist,
      :dataset_deletes,
      :dataset_tracking,
      :emma_items,
      :feed_audit,
      :feed_audit_detail,
      :feed_backups,
      :feed_grin,
      :feed_ia_arkid,
      :feed_log,
      :feed_premis_events,
      :feed_queue,
      :feed_queue_disallow,
      :feed_queue_done,
      :feed_watched_items,
      :feed_zephir_items,
      :gigantic_govdocs,
      :gigantic_govdocs_closed,
      :grants,
      :hf,
      :hf_isbn,
      :hf_issn,
      :hf_lccn,
      :hf_log,
      :hf_oclc,
      :hf_source_bib,
      :holdings_dates,
      :holdings_deltas,
      :holdings_htitem_htmember,
      :holdings_loaded_files,
      :holdings_newitems,
      :ht_billing_members,
      :ht_collection_digitizers,
      :ht_collections,
      :ht_counts,
      :ht_institutions,
      :ht_namespaces,
      :ht_proxies,
      :ht_registered,
      :ht_sessions,
      :ht_survey,
      :ht_users,
      :isbn_dups,
      :mb_coll_item,
      :mb_collection,
      :mb_item,
      :mb_transfer,
      :oclc_concordance,
      :otis_approval_requests,
      :otis_contact_types,
      :otis_contacts,
      :otis_logs,
      :otis_registrations,
      :pod,
      :pt_exclusivity,
      :pt_exclusivity_ng,
      :reasons,
      :rights_current,
      :rights_current_id,
      :rights_log,
      :slip_check_control,
      :slip_commit_control,
      :slip_driver_control,
      :slip_enqueuer_control,
      :slip_error_codes,
      :slip_errors,
      :slip_holdings_version,
      :slip_host_control,
      :slip_indexed,
      :slip_metadata_update_queue,
      :slip_queue,
      :slip_rate_stats,
      :slip_rights,
      :slip_rights_control,
      :slip_rights_timestamp,
      :slip_shard_control,
      :slip_shard_stats,
      :slip_shared_queue,
      :slip_timeouts,
      :slip_vsolr_timestamp,
      :sources,
      :sqt,
      :sr_test,
      :tmp_inappropriate_update_20220613,
      :tmp_not_in_repo_20220613
    ]
  
    HATHIFILES_TABLES = [
      :hf,
      :hf_isbn,
      :hf_issn,
      :hf_lccn,
      :hf_log,
      :hf_oclc,
      :hf_source_bib,
      :schema_info
    ]
    
    HT_MAINTENANCE_TABLES = [
      :pod,
      :slip_check_control,
      :slip_commit_control,
      :slip_driver_control,
      :slip_enqueuer_control,
      :slip_holdings_version,
      :slip_metadata_update_queue,
      :slip_rights,
      :slip_rights_control,
      :slip_rights_timestamp,
      :slip_vsolr_timestamp
    ]
    
    HT_REPOSITORY_TABLES = [
      :access_stmts,
      :access_stmts_map,
      :dataset_blacklist,
      :dataset_deletes,
      :dataset_tracking,
      :emma_items,
      :feed_audit,
      :feed_audit_detail,
      :feed_backups,
      :feed_dataset_tracking,
      :feed_grin,
      :feed_ia_arkid,
      :feed_last_error,
      :feed_log,
      :feed_log_pruned_20230906,
      :feed_mdp_rejects,
      :feed_needs_uplift,
      :feed_premis_events,
      :feed_priority,
      :feed_queue,
      :feed_queue_disallow,
      :feed_queue_done,
      :feed_re_ocred,
      :feed_watched_items,
      :feed_zephir_items,
      :grants,
      :holdings_dates,
      :holdings_deltas,
      :holdings_htitem_htmember,
      :holdings_loaded_files,
      :holdings_newitems,
      :ht_billing_members,
      :ht_collection_digitizers,
      :ht_collections,
      :ht_contact_types,
      :ht_contacts,
      :ht_institutions,
      :ht_institutions_backup_20210309,
      :ht_namespaces,
      :ht_proxies,
      :ht_rubbish,
      :ht_rubbish_pre_nov2012,
      :ht_users,
      :oclc_concordance,
      :oclc_concordance_old,
      :otis_contact_types,
      :otis_contacts,
      :tmp_fix_illinois,
      :tmp_holdings_htmember,
      :tmp_nometa
    ]
  
    HT_RIGHTS_TABLES = [
      :access_profiles,
      :attributes,
      :readable_rights_log,
      :reasons,
      :rights_current,
      :rights_log,
      :sources
    ]
  
    HT_WEB_TABLES = [
      :coll_tmp,
      :ht_2618,
      :ht_approval_requests,
      :ht_counts,
      :ht_logs,
      :ht_registered,
      :ht_sessions,
      :ht_survey,
      :mb_coll_item,
      :mb_collection,
      :mb_collection_dev,
      :mb_item,
      :mb_transfer,
      :otis_approval_requests,
      :otis_logs,
      :otis_registrations,
      :pt_exclusivity,
      :pt_exclusivity_ng,
      :pt_exclusivity_ng_dev,
      :reports_downloads_ssdproxy,
      :reports_downloads_ssdproxy_dev,
      :slip_errors,
      :slip_host_control,
      :slip_indexed,
      :slip_queue,
      :slip_rate_stats,
      :slip_shard_control,
      :slip_shard_stats,
      :slip_shared_queue,
      :slip_timeouts
    ]
  end
end
