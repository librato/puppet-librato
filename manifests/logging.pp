# doc
class librato::logging (
  Boolean $use_log_file = true,
  Boolean $use_syslog = false,
  Boolean $use_logstash = false,
  String $log_file_log_level = 'info',
  String $log_file_filename = '/opt/collectd/var/log/collectd.log',
  Boolean $log_file_timestamp = true,
  Boolean $log_file_print_severity = false,
  String $syslog_log_level = 'info',
  String $logstash_log_level = 'info',
  String $logstash_filename = '/opt/collectd/var/log/collectd.json.log',
) {
  file {"${librato::plugin_config_path}/logging.conf":
    ensure  => file,
    content => epp('librato/logging.conf.epp', {
      'use_log_file'            => $use_log_file,
      'use_syslog'              => $use_syslog,
      'use_logstash'            => $use_logstash,
      'log_file_log_level'      => $log_file_log_level,
      'log_file_filename'       => $log_file_filename,
      'log_file_timestamp'      => $log_file_timestamp,
      'log_file_print_severity' => $log_file_print_severity,
      'syslog_log_level'        => $syslog_log_level,
      'logstash_log_level'      => $logstash_log_level,
      'logstash_filename'       => $logstash_filename
    }),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service[collectd],
    require => Package[collectd-core]
  }
}
