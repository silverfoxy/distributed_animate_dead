-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Aug 01, 2022 at 08:54 PM
-- Server version: 8.0.29
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grafana`
--
CREATE DATABASE IF NOT EXISTS `grafana` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `grafana`;

-- --------------------------------------------------------

--
-- Table structure for table `alert`
--

CREATE TABLE `alert` (
  `id` bigint NOT NULL,
  `version` bigint NOT NULL,
  `dashboard_id` bigint NOT NULL,
  `panel_id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `frequency` bigint NOT NULL,
  `handler` bigint NOT NULL,
  `severity` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `silenced` tinyint(1) NOT NULL,
  `execution_error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `eval_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `eval_date` datetime DEFAULT NULL,
  `new_state_date` datetime NOT NULL,
  `state_changes` int NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `for` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert_configuration`
--

CREATE TABLE `alert_configuration` (
  `id` bigint NOT NULL,
  `alertmanager_configuration` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `configuration_version` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `org_id` bigint NOT NULL DEFAULT '0',
  `configuration_hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not-yet-calculated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `alert_configuration`
--

INSERT INTO `alert_configuration` (`id`, `alertmanager_configuration`, `configuration_version`, `created_at`, `default`, `org_id`, `configuration_hash`) VALUES
(1, '{\n	\"alertmanager_config\": {\n		\"route\": {\n			\"receiver\": \"grafana-default-email\"\n		},\n		\"receivers\": [{\n			\"name\": \"grafana-default-email\",\n			\"grafana_managed_receiver_configs\": [{\n				\"uid\": \"\",\n				\"name\": \"email receiver\",\n				\"type\": \"email\",\n				\"isDefault\": true,\n				\"settings\": {\n					\"addresses\": \"<example@email.com>\"\n				}\n			}]\n		}]\n	}\n}\n', 'v1', 1659387055, 1, 1, '8c409350c88d78d2ee938448449e628d');

-- --------------------------------------------------------

--
-- Table structure for table `alert_image`
--

CREATE TABLE `alert_image` (
  `id` bigint NOT NULL,
  `token` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert_instance`
--

CREATE TABLE `alert_instance` (
  `rule_org_id` bigint NOT NULL,
  `rule_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `labels` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `labels_hash` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_state` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_state_since` bigint NOT NULL,
  `last_eval_time` bigint NOT NULL,
  `current_state_end` bigint NOT NULL DEFAULT '0',
  `current_reason` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert_notification`
--

CREATE TABLE `alert_notification` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `frequency` bigint DEFAULT NULL,
  `send_reminder` tinyint(1) DEFAULT '0',
  `disable_resolve_message` tinyint(1) NOT NULL DEFAULT '0',
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secure_settings` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert_notification_state`
--

CREATE TABLE `alert_notification_state` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `alert_id` bigint NOT NULL,
  `notifier_id` bigint NOT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` bigint NOT NULL,
  `updated_at` bigint NOT NULL,
  `alert_rule_state_updated_version` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert_rule`
--

CREATE TABLE `alert_rule` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `updated` datetime NOT NULL,
  `interval_seconds` bigint NOT NULL DEFAULT '60',
  `version` int NOT NULL DEFAULT '0',
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `namespace_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_data_state` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoData',
  `exec_err_state` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Alerting',
  `for` bigint NOT NULL DEFAULT '0',
  `annotations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `labels` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `dashboard_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `panel_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert_rule_tag`
--

CREATE TABLE `alert_rule_tag` (
  `id` bigint NOT NULL,
  `alert_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `alert_rule_version`
--

CREATE TABLE `alert_rule_version` (
  `id` bigint NOT NULL,
  `rule_org_id` bigint NOT NULL,
  `rule_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `rule_namespace_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_version` int NOT NULL,
  `restored_from` int NOT NULL,
  `version` int NOT NULL,
  `created` datetime NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `interval_seconds` bigint NOT NULL,
  `no_data_state` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoData',
  `exec_err_state` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Alerting',
  `for` bigint NOT NULL DEFAULT '0',
  `annotations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `labels` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `annotation`
--

CREATE TABLE `annotation` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `alert_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `dashboard_id` bigint DEFAULT NULL,
  `panel_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `type` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `metric` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prev_state` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_state` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `epoch` bigint NOT NULL,
  `region_id` bigint DEFAULT '0',
  `tags` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` bigint DEFAULT '0',
  `updated` bigint DEFAULT '0',
  `epoch_end` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `annotation_tag`
--

CREATE TABLE `annotation_tag` (
  `id` bigint NOT NULL,
  `annotation_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_key`
--

CREATE TABLE `api_key` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `expires` bigint DEFAULT NULL,
  `service_account_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `builtin_role`
--

CREATE TABLE `builtin_role` (
  `id` bigint NOT NULL,
  `role` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `org_id` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `builtin_role`
--

INSERT INTO `builtin_role` (`id`, `role`, `role_id`, `created`, `updated`, `org_id`) VALUES
(1, 'Editor', 1, '2022-08-01 20:50:54', '2022-08-01 20:50:54', 1),
(2, 'Viewer', 2, '2022-08-01 20:50:54', '2022-08-01 20:50:54', 1),
(3, 'Admin', 3, '2022-08-01 20:50:54', '2022-08-01 20:50:54', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cache_data`
--

CREATE TABLE `cache_data` (
  `cache_key` varchar(168) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` blob NOT NULL,
  `expires` int NOT NULL,
  `created_at` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard`
--

CREATE TABLE `dashboard` (
  `id` bigint NOT NULL,
  `version` int NOT NULL,
  `slug` varchar(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `gnet_id` bigint DEFAULT NULL,
  `plugin_id` varchar(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` bigint NOT NULL DEFAULT '0',
  `is_folder` tinyint(1) NOT NULL DEFAULT '0',
  `has_acl` tinyint(1) NOT NULL DEFAULT '0',
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dashboard`
--

INSERT INTO `dashboard` (`id`, `version`, `slug`, `title`, `data`, `org_id`, `created`, `updated`, `updated_by`, `created_by`, `gnet_id`, `plugin_id`, `folder_id`, `is_folder`, `has_acl`, `uid`, `is_public`) VALUES
(1, 11, 'executions', 'Executions', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1657047981792,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":8,\"w\":24,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"8.0.5\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}},{\"datasource\":null,\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"thresholds\"},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]},\"unit\":\"short\"},\"overrides\":[]},\"gridPos\":{\"h\":5,\"w\":20,\"x\":2,\"y\":8},\"id\":4,\"options\":{\"colorMode\":\"value\",\"graphMode\":\"area\",\"justifyMode\":\"auto\",\"orientation\":\"auto\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":false},\"text\":{},\"textMode\":\"auto\"},\"pluginVersion\":\"8.0.5\",\"targets\":[{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  new_files + new_lines \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  new_files + new_lines = 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"B\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  new_files + new_lines \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'0\'\",\"refId\":\"C\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  new_files + new_lines = 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"D\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]}],\"title\":\"Finished Execution Coverage\",\"type\":\"stat\"}],\"refresh\":\"\",\"schemaVersion\":30,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":11}', 1, '2021-05-27 15:38:40', '2022-07-05 19:14:41', 1, 1, 0, '', 0, 0, 0, 'h8X96w3Mk', 0),
(2, 1, 'general-alerting', 'General Alerting', '{\"title\":\"General Alerting\",\"uid\":\"dlKiKAkVk\",\"version\":1}', 1, '2022-08-01 20:50:54', '2022-08-01 20:50:54', -8, -8, 0, '', 0, 1, 0, 'dlKiKAkVk', 0);

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_acl`
--

CREATE TABLE `dashboard_acl` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `dashboard_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `team_id` bigint DEFAULT NULL,
  `permission` smallint NOT NULL DEFAULT '4',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dashboard_acl`
--

INSERT INTO `dashboard_acl` (`id`, `org_id`, `dashboard_id`, `user_id`, `team_id`, `permission`, `role`, `created`, `updated`) VALUES
(1, -1, -1, NULL, NULL, 1, 'Viewer', '2017-06-20 00:00:00', '2017-06-20 00:00:00'),
(2, -1, -1, NULL, NULL, 2, 'Editor', '2017-06-20 00:00:00', '2017-06-20 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_provisioning`
--

CREATE TABLE `dashboard_provisioning` (
  `id` bigint NOT NULL,
  `dashboard_id` bigint DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `external_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` int NOT NULL DEFAULT '0',
  `check_sum` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_public_config`
--

CREATE TABLE `dashboard_public_config` (
  `uid` bigint NOT NULL,
  `dashboard_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `refresh_rate` int NOT NULL DEFAULT '30',
  `template_variables` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `time_variables` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_snapshot`
--

CREATE TABLE `dashboard_snapshot` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `delete_key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `external` tinyint(1) NOT NULL,
  `external_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dashboard` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `external_delete_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_encrypted` mediumblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_tag`
--

CREATE TABLE `dashboard_tag` (
  `id` bigint NOT NULL,
  `dashboard_id` bigint NOT NULL,
  `term` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_version`
--

CREATE TABLE `dashboard_version` (
  `id` bigint NOT NULL,
  `dashboard_id` bigint NOT NULL,
  `parent_version` int NOT NULL,
  `restored_from` int NOT NULL,
  `version` int NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dashboard_version`
--

INSERT INTO `dashboard_version` (`id`, `dashboard_id`, `parent_version`, `restored_from`, `version`, `created`, `created_by`, `message`, `data`) VALUES
(1, 1, 0, 0, 1, '2021-05-27 15:38:41', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"hideControls\":false,\"id\":null,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":true,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":2,\"points\":false,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"}]}],\"thresholds\":[],\"timeRegions\":[],\"title\":\"Tasks inflow\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true}],\"yaxis\":{\"align\":false,\"alignLevel\":null}}],\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT log_filename from jobs WHERE log_filename \\u003c\\u003e \\\"\\\"\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT log_filename from jobs WHERE log_filename \\u003c\\u003e \\\"\\\"\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":1}'),
(2, 1, 1, 0, 2, '2021-05-27 17:35:03', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622129924345,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":true,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":2,\"points\":false,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[{\"params\":[\"$__interval\",\"none\"],\"type\":\"time\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  timestamp as \\\"time\\\",\\n  count(id) AS \\\"priority\\\",\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nGROUP BY 1\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"count\"],\"type\":\"aggregate\"},{\"params\":[\"priority\"],\"type\":\"alias\"}],[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"count\"],\"type\":\"aggregate\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Tasks inflow\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true}],\"yaxis\":{\"align\":false,\"alignLevel\":null}}],\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":2}'),
(6, 1, 2, 0, 3, '2021-05-27 17:37:37', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622136908137,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true}],\"yaxis\":{\"align\":false,\"alignLevel\":null}}],\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":3}'),
(7, 1, 3, 0, 4, '2021-05-27 17:39:19', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622136908137,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}}],\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":4}'),
(8, 1, 4, 0, 5, '2021-05-27 19:05:17', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622136908137,\"links\":[],\"panels\":[{\"datasource\":null,\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"thresholds\"},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":8,\"w\":12,\"x\":0,\"y\":0},\"id\":4,\"options\":{\"colorMode\":\"value\",\"graphMode\":\"area\",\"justifyMode\":\"auto\",\"orientation\":\"auto\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":false},\"text\":{},\"textMode\":\"auto\"},\"pluginVersion\":\"7.5.4\",\"targets\":[{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"C\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]}],\"title\":\"Finished Execution Coverage\",\"type\":\"stat\"},{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":8,\"w\":24,\"x\":0,\"y\":8},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}}],\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":5}'),
(9, 1, 5, 0, 6, '2021-05-27 22:06:00', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622153147503,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":8,\"w\":24,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}},{\"datasource\":null,\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"thresholds\"},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":5,\"w\":10,\"x\":0,\"y\":8},\"id\":4,\"options\":{\"colorMode\":\"value\",\"graphMode\":\"area\",\"justifyMode\":\"auto\",\"orientation\":\"auto\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":false},\"text\":{},\"textMode\":\"auto\"},\"pluginVersion\":\"7.5.4\",\"targets\":[{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"C\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]}],\"title\":\"Finished Execution Coverage\",\"type\":\"stat\"}],\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":6}'),
(10, 1, 6, 0, 7, '2021-05-28 15:15:37', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622209398159,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":8,\"w\":24,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}},{\"datasource\":null,\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"thresholds\"},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":5,\"w\":10,\"x\":0,\"y\":8},\"id\":4,\"options\":{\"colorMode\":\"value\",\"graphMode\":\"area\",\"justifyMode\":\"auto\",\"orientation\":\"auto\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":false},\"text\":{},\"textMode\":\"auto\"},\"pluginVersion\":\"7.5.4\",\"targets\":[{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"B\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"C\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"D\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]}],\"title\":\"Finished Execution Coverage\",\"type\":\"stat\"}],\"refresh\":\"30m\",\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":7}'),
(11, 1, 7, 0, 8, '2021-05-28 15:16:09', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622209398159,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":8,\"w\":24,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}},{\"datasource\":null,\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"thresholds\"},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":5,\"w\":20,\"x\":2,\"y\":8},\"id\":4,\"options\":{\"colorMode\":\"value\",\"graphMode\":\"area\",\"justifyMode\":\"auto\",\"orientation\":\"auto\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":false},\"text\":{},\"textMode\":\"auto\"},\"pluginVersion\":\"7.5.4\",\"targets\":[{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"B\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"C\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"D\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]}],\"title\":\"Finished Execution Coverage\",\"type\":\"stat\"}],\"refresh\":\"30m\",\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":8}'),
(12, 1, 8, 0, 9, '2021-05-28 15:18:13', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622209398159,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":8,\"w\":24,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}},{\"datasource\":null,\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"thresholds\"},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]},\"unit\":\"short\"},\"overrides\":[]},\"gridPos\":{\"h\":5,\"w\":20,\"x\":2,\"y\":8},\"id\":4,\"options\":{\"colorMode\":\"value\",\"graphMode\":\"area\",\"justifyMode\":\"auto\",\"orientation\":\"auto\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":false},\"text\":{},\"textMode\":\"auto\"},\"pluginVersion\":\"7.5.4\",\"targets\":[{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"B\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"C\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"D\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]}],\"title\":\"Finished Execution Coverage\",\"type\":\"stat\"}],\"refresh\":\"30m\",\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":9}');
INSERT INTO `dashboard_version` (`id`, `dashboard_id`, `parent_version`, `restored_from`, `version`, `created`, `created_by`, `message`, `data`) VALUES
(13, 1, 9, 0, 10, '2021-05-28 15:18:17', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1622209398159,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fieldConfig\":{\"defaults\":{},\"overrides\":[]},\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":8,\"w\":24,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"7.5.4\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}},{\"datasource\":null,\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"thresholds\"},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]},\"unit\":\"short\"},\"overrides\":[]},\"gridPos\":{\"h\":5,\"w\":20,\"x\":2,\"y\":8},\"id\":4,\"options\":{\"colorMode\":\"value\",\"graphMode\":\"area\",\"justifyMode\":\"auto\",\"orientation\":\"auto\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":false},\"text\":{},\"textMode\":\"auto\"},\"pluginVersion\":\"7.5.4\",\"targets\":[{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"B\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"C\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  priority = 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"D\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]}],\"title\":\"Finished Execution Coverage\",\"type\":\"stat\"}],\"refresh\":\"30m\",\"schemaVersion\":27,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tags\":[],\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":10}'),
(14, 1, 10, 0, 11, '2022-07-05 19:14:41', 1, '', '{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":\"-- Grafana --\",\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"type\":\"dashboard\"}]},\"editable\":true,\"gnetId\":null,\"graphTooltip\":0,\"id\":1,\"iteration\":1657047981792,\"links\":[],\"panels\":[{\"aliasColors\":{},\"bars\":false,\"dashLength\":10,\"dashes\":false,\"datasource\":null,\"fill\":1,\"fillGradient\":0,\"gridPos\":{\"h\":8,\"w\":24,\"x\":0,\"y\":0},\"hiddenSeries\":false,\"id\":2,\"legend\":{\"avg\":false,\"current\":false,\"max\":false,\"min\":false,\"show\":true,\"total\":false,\"values\":false},\"lines\":false,\"linewidth\":1,\"nullPointMode\":\"null\",\"options\":{\"alertThreshold\":true},\"percentage\":false,\"pluginVersion\":\"8.0.5\",\"pointradius\":1,\"points\":true,\"renderer\":\"flot\",\"seriesOverrides\":[],\"spaceLength\":10,\"stack\":false,\"steppedLine\":false,\"targets\":[{\"format\":\"time_series\",\"group\":[],\"hide\":false,\"metricColumn\":\"none\",\"rawQuery\":false,\"rawSql\":\"SELECT\\n  timestamp AS \\\"time\\\",\\n  priority\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  fk_task_execution_id IN ($Logs)\\nORDER BY timestamp\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"}]}],\"thresholds\":[],\"timeFrom\":null,\"timeRegions\":[],\"timeShift\":null,\"title\":\"Job Priorities\",\"tooltip\":{\"shared\":true,\"sort\":0,\"value_type\":\"individual\"},\"type\":\"graph\",\"xaxis\":{\"buckets\":null,\"mode\":\"time\",\"name\":null,\"show\":true,\"values\":[]},\"yaxes\":[{\"$$hashKey\":\"object:156\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":true},{\"$$hashKey\":\"object:157\",\"format\":\"short\",\"label\":null,\"logBase\":1,\"max\":null,\"min\":null,\"show\":false}],\"yaxis\":{\"align\":false,\"alignLevel\":null}},{\"datasource\":null,\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"thresholds\"},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]},\"unit\":\"short\"},\"overrides\":[]},\"gridPos\":{\"h\":5,\"w\":20,\"x\":2,\"y\":8},\"id\":4,\"options\":{\"colorMode\":\"value\",\"graphMode\":\"area\",\"justifyMode\":\"auto\",\"orientation\":\"auto\",\"reduceOptions\":{\"calcs\":[\"lastNotNull\"],\"fields\":\"\",\"values\":false},\"text\":{},\"textMode\":\"auto\"},\"pluginVersion\":\"8.0.5\",\"targets\":[{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  new_files + new_lines \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"A\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Termination) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  new_files + new_lines = 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'1\'\",\"refId\":\"B\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage \\u003e 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  new_files + new_lines \\u003e 0 AND\\n  fk_task_execution_id IN ($Logs) AND\\n  termination = \'0\'\",\"refId\":\"C\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]},{\"format\":\"table\",\"group\":[{\"params\":[\"id\"],\"type\":\"column\"}],\"hide\":false,\"metricColumn\":\"id\",\"rawQuery\":true,\"rawSql\":\"SELECT\\n  count(id) AS \\\"(Reanimation) New Coverage = 0\\\"\\nFROM executions\\nWHERE\\n  $__timeFilter(timestamp) AND\\n  new_files + new_lines = 0 AND\\n  fk_task_execution_id IN ($Logs)\",\"refId\":\"D\",\"select\":[[{\"params\":[\"priority\"],\"type\":\"column\"},{\"params\":[\"priority\"],\"type\":\"alias\"}]],\"table\":\"executions\",\"timeColumn\":\"timestamp\",\"timeColumnType\":\"timestamp\",\"where\":[{\"name\":\"$__timeFilter\",\"params\":[],\"type\":\"macro\"},{\"datatype\":\"int\",\"name\":\"\",\"params\":[\"priority\",\"\\u003e\",\"0\"],\"type\":\"expression\"},{\"datatype\":\"varchar\",\"name\":\"\",\"params\":[\"fk_task_execution_id\",\"IN\",\"($Logs)\"],\"type\":\"expression\"},{\"datatype\":\"tinyint\",\"name\":\"\",\"params\":[\"termination\",\"=\",\"\'1\'\"],\"type\":\"expression\"}]}],\"title\":\"Finished Execution Coverage\",\"type\":\"stat\"}],\"refresh\":\"\",\"schemaVersion\":30,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"allValue\":null,\"current\":{\"selected\":false,\"text\":\"All\",\"value\":\"$__all\"},\"datasource\":null,\"definition\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"description\":null,\"error\":null,\"hide\":0,\"includeAll\":true,\"label\":\"Logs\",\"multi\":true,\"name\":\"Logs\",\"options\":[],\"query\":\"SELECT concat(log_filename, \\\"_\\\", timestamp) as \\\"__text\\\", execution_id as \\\"__value\\\" from jobs\",\"refresh\":2,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":1,\"tagValuesQuery\":\"\",\"tagsQuery\":\"\",\"type\":\"query\",\"useTags\":false}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"Executions\",\"uid\":\"h8X96w3Mk\",\"version\":11}'),
(15, 2, 0, 0, 1, '2022-08-01 20:50:54', -8, '', '{\"title\":\"General Alerting\",\"uid\":\"dlKiKAkVk\",\"version\":1}');

-- --------------------------------------------------------

--
-- Table structure for table `data_keys`
--

CREATE TABLE `data_keys` (
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `scope` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `encrypted_data` blob NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_keys`
--

INSERT INTO `data_keys` (`name`, `active`, `scope`, `provider`, `encrypted_data`, `created`, `updated`, `label`) VALUES
('N4jmKAz4z', 1, 'root', 'secretKey.v1', 0x556654304151666ba6b9997db781bfc1bbc5cac01cb29221a6d5731931862c57d6e1fd4cce8c6f84, '2022-08-01 20:51:12', '2022-08-01 20:51:12', '2022-08-01/root@secretKey.v1');

-- --------------------------------------------------------

--
-- Table structure for table `data_source`
--

CREATE TABLE `data_source` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `version` int NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `database` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_auth` tinyint(1) NOT NULL,
  `basic_auth_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_auth_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  `json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `with_credentials` tinyint(1) NOT NULL DEFAULT '0',
  `secure_json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `read_only` tinyint(1) DEFAULT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_source`
--

INSERT INTO `data_source` (`id`, `org_id`, `version`, `type`, `name`, `access`, `url`, `password`, `user`, `database`, `basic_auth`, `basic_auth_user`, `basic_auth_password`, `is_default`, `json_data`, `created`, `updated`, `with_credentials`, `secure_json_data`, `read_only`, `uid`) VALUES
(1, 1, 2, 'mysql', 'MySQL', 'proxy', 'db', '', 'root', 'animatedead_executions', 0, '', '', 1, '{}', '2021-05-27 15:15:49', '2021-05-27 15:20:54', 0, '{\"password\":\"NENhQ3Ayd1Ak4ImfQS5Ourk5y6k6kho6bNpiUw==\"}', 0, 'tVg-qQqGz');

-- --------------------------------------------------------

--
-- Table structure for table `entity_event`
--

CREATE TABLE `entity_event` (
  `id` bigint NOT NULL,
  `entity_id` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file`
--

CREATE TABLE `file` (
  `path` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_folder_path_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contents` blob NOT NULL,
  `etag` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cache_control` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_disposition` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  `size` bigint NOT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_meta`
--

CREATE TABLE `file_meta` (
  `path_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kv_store`
--

CREATE TABLE `kv_store` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `namespace` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `library_element`
--

CREATE TABLE `library_element` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `folder_id` bigint NOT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kind` bigint NOT NULL,
  `type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` bigint NOT NULL,
  `version` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `library_element_connection`
--

CREATE TABLE `library_element_connection` (
  `id` bigint NOT NULL,
  `element_id` bigint NOT NULL,
  `kind` bigint NOT NULL,
  `connection_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempt`
--

CREATE TABLE `login_attempt` (
  `id` bigint NOT NULL,
  `username` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migration_log`
--

CREATE TABLE `migration_log` (
  `id` bigint NOT NULL,
  `migration_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sql` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `success` tinyint(1) NOT NULL,
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migration_log`
--

INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES
(1, 'create migration_log table', 'CREATE TABLE IF NOT EXISTS `migration_log` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `migration_id` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `sql` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `success` TINYINT(1) NOT NULL\n, `error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `timestamp` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:20:56'),
(2, 'create user table', 'CREATE TABLE IF NOT EXISTS `user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `account_id` BIGINT(20) NOT NULL\n, `is_admin` TINYINT(1) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:20:57'),
(3, 'add unique index user.login', 'CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);', 1, '', '2021-05-25 22:20:58'),
(4, 'add unique index user.email', 'CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);', 1, '', '2021-05-25 22:20:59'),
(5, 'drop index UQE_user_login - v1', 'DROP INDEX `UQE_user_login` ON `user`', 1, '', '2021-05-25 22:20:59'),
(6, 'drop index UQE_user_email - v1', 'DROP INDEX `UQE_user_email` ON `user`', 1, '', '2021-05-25 22:20:59'),
(7, 'Rename table user to user_v1 - v1', 'ALTER TABLE `user` RENAME TO `user_v1`', 1, '', '2021-05-25 22:20:59'),
(8, 'create user table v2', 'CREATE TABLE IF NOT EXISTS `user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `org_id` BIGINT(20) NOT NULL\n, `is_admin` TINYINT(1) NOT NULL\n, `email_verified` TINYINT(1) NULL\n, `theme` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:00'),
(9, 'create index UQE_user_login - v2', 'CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);', 1, '', '2021-05-25 22:21:01'),
(10, 'create index UQE_user_email - v2', 'CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);', 1, '', '2021-05-25 22:21:01'),
(11, 'copy data_source v1 to v2', 'INSERT INTO `user` (`rands`\n, `company`\n, `org_id`\n, `is_admin`\n, `created`\n, `id`\n, `login`\n, `password`\n, `salt`\n, `updated`\n, `version`\n, `email`\n, `name`) SELECT `rands`\n, `company`\n, `account_id`\n, `is_admin`\n, `created`\n, `id`\n, `login`\n, `password`\n, `salt`\n, `updated`\n, `version`\n, `email`\n, `name` FROM `user_v1`', 1, '', '2021-05-25 22:21:02'),
(12, 'Drop old table user_v1', 'DROP TABLE IF EXISTS `user_v1`', 1, '', '2021-05-25 22:21:02'),
(13, 'Add column help_flags1 to user table', 'alter table `user` ADD COLUMN `help_flags1` BIGINT(20) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:21:02'),
(14, 'Update user table charset', 'ALTER TABLE `user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `theme` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;', 1, '', '2021-05-25 22:21:02'),
(15, 'Add last_seen_at column to user', 'alter table `user` ADD COLUMN `last_seen_at` DATETIME NULL ', 1, '', '2021-05-25 22:21:03'),
(16, 'Add missing user data', 'code migration', 1, '', '2021-05-25 22:21:03'),
(17, 'Add is_disabled column to user', 'alter table `user` ADD COLUMN `is_disabled` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:21:03'),
(18, 'Add index user.login/user.email', 'CREATE INDEX `IDX_user_login_email` ON `user` (`login`,`email`);', 1, '', '2021-05-25 22:21:03'),
(19, 'create temp user table v1-7', 'CREATE TABLE IF NOT EXISTS `temp_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `invited_by_user_id` BIGINT(20) NULL\n, `email_sent` TINYINT(1) NOT NULL\n, `email_sent_on` DATETIME NULL\n, `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:04'),
(20, 'create index IDX_temp_user_email - v1-7', 'CREATE INDEX `IDX_temp_user_email` ON `temp_user` (`email`);', 1, '', '2021-05-25 22:21:04'),
(21, 'create index IDX_temp_user_org_id - v1-7', 'CREATE INDEX `IDX_temp_user_org_id` ON `temp_user` (`org_id`);', 1, '', '2021-05-25 22:21:05'),
(22, 'create index IDX_temp_user_code - v1-7', 'CREATE INDEX `IDX_temp_user_code` ON `temp_user` (`code`);', 1, '', '2021-05-25 22:21:05'),
(23, 'create index IDX_temp_user_status - v1-7', 'CREATE INDEX `IDX_temp_user_status` ON `temp_user` (`status`);', 1, '', '2021-05-25 22:21:05'),
(24, 'Update temp_user table charset', 'ALTER TABLE `temp_user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;', 1, '', '2021-05-25 22:21:06'),
(25, 'drop index IDX_temp_user_email - v1', 'DROP INDEX `IDX_temp_user_email` ON `temp_user`', 1, '', '2021-05-25 22:21:06'),
(26, 'drop index IDX_temp_user_org_id - v1', 'DROP INDEX `IDX_temp_user_org_id` ON `temp_user`', 1, '', '2021-05-25 22:21:06'),
(27, 'drop index IDX_temp_user_code - v1', 'DROP INDEX `IDX_temp_user_code` ON `temp_user`', 1, '', '2021-05-25 22:21:06'),
(28, 'drop index IDX_temp_user_status - v1', 'DROP INDEX `IDX_temp_user_status` ON `temp_user`', 1, '', '2021-05-25 22:21:07'),
(29, 'Rename table temp_user to temp_user_tmp_qwerty - v1', 'ALTER TABLE `temp_user` RENAME TO `temp_user_tmp_qwerty`', 1, '', '2021-05-25 22:21:07'),
(30, 'create temp_user v2', 'CREATE TABLE IF NOT EXISTS `temp_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `invited_by_user_id` BIGINT(20) NULL\n, `email_sent` TINYINT(1) NOT NULL\n, `email_sent_on` DATETIME NULL\n, `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` INT NOT NULL DEFAULT 0\n, `updated` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:07'),
(31, 'create index IDX_temp_user_email - v2', 'CREATE INDEX `IDX_temp_user_email` ON `temp_user` (`email`);', 1, '', '2021-05-25 22:21:08'),
(32, 'create index IDX_temp_user_org_id - v2', 'CREATE INDEX `IDX_temp_user_org_id` ON `temp_user` (`org_id`);', 1, '', '2021-05-25 22:21:08'),
(33, 'create index IDX_temp_user_code - v2', 'CREATE INDEX `IDX_temp_user_code` ON `temp_user` (`code`);', 1, '', '2021-05-25 22:21:08'),
(34, 'create index IDX_temp_user_status - v2', 'CREATE INDEX `IDX_temp_user_status` ON `temp_user` (`status`);', 1, '', '2021-05-25 22:21:09'),
(35, 'copy temp_user v1 to v2', 'INSERT INTO `temp_user` (`org_id`\n, `version`\n, `name`\n, `code`\n, `email_sent`\n, `remote_addr`\n, `id`\n, `email`\n, `role`\n, `status`\n, `invited_by_user_id`\n, `email_sent_on`) SELECT `org_id`\n, `version`\n, `name`\n, `code`\n, `email_sent`\n, `remote_addr`\n, `id`\n, `email`\n, `role`\n, `status`\n, `invited_by_user_id`\n, `email_sent_on` FROM `temp_user_tmp_qwerty`', 1, '', '2021-05-25 22:21:09'),
(36, 'drop temp_user_tmp_qwerty', 'DROP TABLE IF EXISTS `temp_user_tmp_qwerty`', 1, '', '2021-05-25 22:21:09'),
(37, 'Set created for temp users that will otherwise prematurely expire', 'code migration', 1, '', '2021-05-25 22:21:09'),
(38, 'create star table', 'CREATE TABLE IF NOT EXISTS `star` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:10'),
(39, 'add unique index star.user_id_dashboard_id', 'CREATE UNIQUE INDEX `UQE_star_user_id_dashboard_id` ON `star` (`user_id`,`dashboard_id`);', 1, '', '2021-05-25 22:21:10'),
(40, 'create org table v1', 'CREATE TABLE IF NOT EXISTS `org` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `address1` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `address2` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `city` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `state` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `zip_code` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `country` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `billing_email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:10'),
(41, 'create index UQE_org_name - v1', 'CREATE UNIQUE INDEX `UQE_org_name` ON `org` (`name`);', 1, '', '2021-05-25 22:21:11'),
(42, 'create org_user table v1', 'CREATE TABLE IF NOT EXISTS `org_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:11'),
(43, 'create index IDX_org_user_org_id - v1', 'CREATE INDEX `IDX_org_user_org_id` ON `org_user` (`org_id`);', 1, '', '2021-05-25 22:21:12'),
(44, 'create index UQE_org_user_org_id_user_id - v1', 'CREATE UNIQUE INDEX `UQE_org_user_org_id_user_id` ON `org_user` (`org_id`,`user_id`);', 1, '', '2021-05-25 22:21:12'),
(45, 'Update org table charset', 'ALTER TABLE `org` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `address1` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `address2` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `city` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `state` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `zip_code` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `country` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `billing_email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;', 1, '', '2021-05-25 22:21:13'),
(46, 'Update org_user table charset', 'ALTER TABLE `org_user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:21:13'),
(47, 'Migrate all Read Only Viewers to Viewers', 'UPDATE org_user SET role = \'Viewer\' WHERE role = \'Read Only Editor\'', 1, '', '2021-05-25 22:21:13'),
(48, 'create dashboard table', 'CREATE TABLE IF NOT EXISTS `dashboard` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:13'),
(49, 'add index dashboard.account_id', 'CREATE INDEX `IDX_dashboard_account_id` ON `dashboard` (`account_id`);', 1, '', '2021-05-25 22:21:13'),
(50, 'add unique index dashboard_account_id_slug', 'CREATE UNIQUE INDEX `UQE_dashboard_account_id_slug` ON `dashboard` (`account_id`,`slug`);', 1, '', '2021-05-25 22:21:14'),
(51, 'create dashboard_tag table', 'CREATE TABLE IF NOT EXISTS `dashboard_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `term` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:14'),
(52, 'add unique index dashboard_tag.dasboard_id_term', 'CREATE UNIQUE INDEX `UQE_dashboard_tag_dashboard_id_term` ON `dashboard_tag` (`dashboard_id`,`term`);', 1, '', '2021-05-25 22:21:15'),
(53, 'drop index UQE_dashboard_tag_dashboard_id_term - v1', 'DROP INDEX `UQE_dashboard_tag_dashboard_id_term` ON `dashboard_tag`', 1, '', '2021-05-25 22:21:15'),
(54, 'Rename table dashboard to dashboard_v1 - v1', 'ALTER TABLE `dashboard` RENAME TO `dashboard_v1`', 1, '', '2021-05-25 22:21:15'),
(55, 'create dashboard v2', 'CREATE TABLE IF NOT EXISTS `dashboard` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:16'),
(56, 'create index IDX_dashboard_org_id - v2', 'CREATE INDEX `IDX_dashboard_org_id` ON `dashboard` (`org_id`);', 1, '', '2021-05-25 22:21:16'),
(57, 'create index UQE_dashboard_org_id_slug - v2', 'CREATE UNIQUE INDEX `UQE_dashboard_org_id_slug` ON `dashboard` (`org_id`,`slug`);', 1, '', '2021-05-25 22:21:16'),
(58, 'copy dashboard v1 to v2', 'INSERT INTO `dashboard` (`created`\n, `updated`\n, `id`\n, `version`\n, `slug`\n, `title`\n, `data`\n, `org_id`) SELECT `created`\n, `updated`\n, `id`\n, `version`\n, `slug`\n, `title`\n, `data`\n, `account_id` FROM `dashboard_v1`', 1, '', '2021-05-25 22:21:17'),
(59, 'drop table dashboard_v1', 'DROP TABLE IF EXISTS `dashboard_v1`', 1, '', '2021-05-25 22:21:17'),
(60, 'alter dashboard.data to mediumtext v1', 'ALTER TABLE dashboard MODIFY data MEDIUMTEXT;', 1, '', '2021-05-25 22:21:17'),
(61, 'Add column updated_by in dashboard - v2', 'alter table `dashboard` ADD COLUMN `updated_by` INT NULL ', 1, '', '2021-05-25 22:21:18'),
(62, 'Add column created_by in dashboard - v2', 'alter table `dashboard` ADD COLUMN `created_by` INT NULL ', 1, '', '2021-05-25 22:21:19'),
(63, 'Add column gnetId in dashboard', 'alter table `dashboard` ADD COLUMN `gnet_id` BIGINT(20) NULL ', 1, '', '2021-05-25 22:21:19'),
(64, 'Add index for gnetId in dashboard', 'CREATE INDEX `IDX_dashboard_gnet_id` ON `dashboard` (`gnet_id`);', 1, '', '2021-05-25 22:21:19'),
(65, 'Add column plugin_id in dashboard', 'alter table `dashboard` ADD COLUMN `plugin_id` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:21:20'),
(66, 'Add index for plugin_id in dashboard', 'CREATE INDEX `IDX_dashboard_org_id_plugin_id` ON `dashboard` (`org_id`,`plugin_id`);', 1, '', '2021-05-25 22:21:20'),
(67, 'Add index for dashboard_id in dashboard_tag', 'CREATE INDEX `IDX_dashboard_tag_dashboard_id` ON `dashboard_tag` (`dashboard_id`);', 1, '', '2021-05-25 22:21:21'),
(68, 'Update dashboard table charset', 'ALTER TABLE `dashboard` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `plugin_id` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `data` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:21:21'),
(69, 'Update dashboard_tag table charset', 'ALTER TABLE `dashboard_tag` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `term` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:21:22'),
(70, 'Add column folder_id in dashboard', 'alter table `dashboard` ADD COLUMN `folder_id` BIGINT(20) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:21:22'),
(71, 'Add column isFolder in dashboard', 'alter table `dashboard` ADD COLUMN `is_folder` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:21:23'),
(72, 'Add column has_acl in dashboard', 'alter table `dashboard` ADD COLUMN `has_acl` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:21:23'),
(73, 'Add column uid in dashboard', 'alter table `dashboard` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:21:23'),
(74, 'Update uid column values in dashboard', 'UPDATE dashboard SET uid=lpad(id,9,\'0\') WHERE uid IS NULL;', 1, '', '2021-05-25 22:21:24'),
(75, 'Add unique index dashboard_org_id_uid', 'CREATE UNIQUE INDEX `UQE_dashboard_org_id_uid` ON `dashboard` (`org_id`,`uid`);', 1, '', '2021-05-25 22:21:24'),
(76, 'Remove unique index org_id_slug', 'DROP INDEX `UQE_dashboard_org_id_slug` ON `dashboard`', 1, '', '2021-05-25 22:21:24'),
(77, 'Update dashboard title length', 'ALTER TABLE `dashboard` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `title` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:21:24'),
(78, 'Add unique index for dashboard_org_id_title_folder_id', 'CREATE UNIQUE INDEX `UQE_dashboard_org_id_folder_id_title` ON `dashboard` (`org_id`,`folder_id`,`title`);', 1, '', '2021-05-25 22:21:27'),
(79, 'create dashboard_provisioning', 'CREATE TABLE IF NOT EXISTS `dashboard_provisioning` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `external_id` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:27'),
(80, 'Rename table dashboard_provisioning to dashboard_provisioning_tmp_qwerty - v1', 'ALTER TABLE `dashboard_provisioning` RENAME TO `dashboard_provisioning_tmp_qwerty`', 1, '', '2021-05-25 22:21:28'),
(81, 'create dashboard_provisioning v2', 'CREATE TABLE IF NOT EXISTS `dashboard_provisioning` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `external_id` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:28'),
(82, 'create index IDX_dashboard_provisioning_dashboard_id - v2', 'CREATE INDEX `IDX_dashboard_provisioning_dashboard_id` ON `dashboard_provisioning` (`dashboard_id`);', 1, '', '2021-05-25 22:21:29'),
(83, 'create index IDX_dashboard_provisioning_dashboard_id_name - v2', 'CREATE INDEX `IDX_dashboard_provisioning_dashboard_id_name` ON `dashboard_provisioning` (`dashboard_id`,`name`);', 1, '', '2021-05-25 22:21:29'),
(84, 'copy dashboard_provisioning v1 to v2', 'INSERT INTO `dashboard_provisioning` (`dashboard_id`\n, `name`\n, `external_id`\n, `id`) SELECT `dashboard_id`\n, `name`\n, `external_id`\n, `id` FROM `dashboard_provisioning_tmp_qwerty`', 1, '', '2021-05-25 22:21:30'),
(85, 'drop dashboard_provisioning_tmp_qwerty', 'DROP TABLE IF EXISTS `dashboard_provisioning_tmp_qwerty`', 1, '', '2021-05-25 22:21:30'),
(86, 'Add check_sum column', 'alter table `dashboard_provisioning` ADD COLUMN `check_sum` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:21:31'),
(87, 'Add index for dashboard_title', 'CREATE INDEX `IDX_dashboard_title` ON `dashboard` (`title`);', 1, '', '2021-05-25 22:21:31'),
(88, 'delete tags for deleted dashboards', 'DELETE FROM dashboard_tag WHERE dashboard_id NOT IN (SELECT id FROM dashboard)', 1, '', '2021-05-25 22:21:32'),
(89, 'delete stars for deleted dashboards', 'DELETE FROM star WHERE dashboard_id NOT IN (SELECT id FROM dashboard)', 1, '', '2021-05-25 22:21:32'),
(90, 'create data_source table', 'CREATE TABLE IF NOT EXISTS `data_source` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth` TINYINT(1) NOT NULL\n, `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `is_default` TINYINT(1) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:33'),
(91, 'add index data_source.account_id', 'CREATE INDEX `IDX_data_source_account_id` ON `data_source` (`account_id`);', 1, '', '2021-05-25 22:21:35'),
(92, 'add unique index data_source.account_id_name', 'CREATE UNIQUE INDEX `UQE_data_source_account_id_name` ON `data_source` (`account_id`,`name`);', 1, '', '2021-05-25 22:21:35'),
(93, 'drop index IDX_data_source_account_id - v1', 'DROP INDEX `IDX_data_source_account_id` ON `data_source`', 1, '', '2021-05-25 22:21:36'),
(94, 'drop index UQE_data_source_account_id_name - v1', 'DROP INDEX `UQE_data_source_account_id_name` ON `data_source`', 1, '', '2021-05-25 22:21:37'),
(95, 'Rename table data_source to data_source_v1 - v1', 'ALTER TABLE `data_source` RENAME TO `data_source_v1`', 1, '', '2021-05-25 22:21:37'),
(96, 'create data_source table v2', 'CREATE TABLE IF NOT EXISTS `data_source` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth` TINYINT(1) NOT NULL\n, `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `is_default` TINYINT(1) NOT NULL\n, `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:38'),
(97, 'create index IDX_data_source_org_id - v2', 'CREATE INDEX `IDX_data_source_org_id` ON `data_source` (`org_id`);', 1, '', '2021-05-25 22:21:39'),
(98, 'create index UQE_data_source_org_id_name - v2', 'CREATE UNIQUE INDEX `UQE_data_source_org_id_name` ON `data_source` (`org_id`,`name`);', 1, '', '2021-05-25 22:21:41'),
(99, 'copy data_source v1 to v2', 'INSERT INTO `data_source` (`user`\n, `id`\n, `version`\n, `url`\n, `database`\n, `basic_auth_password`\n, `updated`\n, `org_id`\n, `type`\n, `is_default`\n, `created`\n, `password`\n, `basic_auth`\n, `basic_auth_user`\n, `name`\n, `access`) SELECT `user`\n, `id`\n, `version`\n, `url`\n, `database`\n, `basic_auth_password`\n, `updated`\n, `account_id`\n, `type`\n, `is_default`\n, `created`\n, `password`\n, `basic_auth`\n, `basic_auth_user`\n, `name`\n, `access` FROM `data_source_v1`', 1, '', '2021-05-25 22:21:41'),
(100, 'Drop old table data_source_v1 #2', 'DROP TABLE IF EXISTS `data_source_v1`', 1, '', '2021-05-25 22:21:41'),
(101, 'Add column with_credentials', 'alter table `data_source` ADD COLUMN `with_credentials` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:21:42'),
(102, 'Add secure json data column', 'alter table `data_source` ADD COLUMN `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:21:43'),
(103, 'Update data_source table charset', 'ALTER TABLE `data_source` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;', 1, '', '2021-05-25 22:21:43'),
(104, 'Update initial version to 1', 'UPDATE data_source SET version = 1 WHERE version = 0', 1, '', '2021-05-25 22:21:44'),
(105, 'Add read_only data column', 'alter table `data_source` ADD COLUMN `read_only` TINYINT(1) NULL ', 1, '', '2021-05-25 22:21:44'),
(106, 'Migrate logging ds to loki ds', 'UPDATE data_source SET type = \'loki\' WHERE type = \'logging\'', 1, '', '2021-05-25 22:21:44'),
(107, 'Update json_data with nulls', 'UPDATE data_source SET json_data = \'{}\' WHERE json_data is null', 1, '', '2021-05-25 22:21:44'),
(108, 'Add uid column', 'alter table `data_source` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:21:45'),
(109, 'Update uid value', 'UPDATE data_source SET uid=lpad(id,9,\'0\');', 1, '', '2021-05-25 22:21:45'),
(110, 'Add unique index datasource_org_id_uid', 'CREATE UNIQUE INDEX `UQE_data_source_org_id_uid` ON `data_source` (`org_id`,`uid`);', 1, '', '2021-05-25 22:21:45'),
(111, 'add unique index datasource_org_id_is_default', 'CREATE INDEX `IDX_data_source_org_id_is_default` ON `data_source` (`org_id`,`is_default`);', 1, '', '2021-05-25 22:21:47'),
(112, 'create api_key table', 'CREATE TABLE IF NOT EXISTS `api_key` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:48'),
(113, 'add index api_key.account_id', 'CREATE INDEX `IDX_api_key_account_id` ON `api_key` (`account_id`);', 1, '', '2021-05-25 22:21:49'),
(114, 'add index api_key.key', 'CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);', 1, '', '2021-05-25 22:21:50'),
(115, 'add index api_key.account_id_name', 'CREATE UNIQUE INDEX `UQE_api_key_account_id_name` ON `api_key` (`account_id`,`name`);', 1, '', '2021-05-25 22:21:51'),
(116, 'drop index IDX_api_key_account_id - v1', 'DROP INDEX `IDX_api_key_account_id` ON `api_key`', 1, '', '2021-05-25 22:21:52'),
(117, 'drop index UQE_api_key_key - v1', 'DROP INDEX `UQE_api_key_key` ON `api_key`', 1, '', '2021-05-25 22:21:53'),
(118, 'drop index UQE_api_key_account_id_name - v1', 'DROP INDEX `UQE_api_key_account_id_name` ON `api_key`', 1, '', '2021-05-25 22:21:54'),
(119, 'Rename table api_key to api_key_v1 - v1', 'ALTER TABLE `api_key` RENAME TO `api_key_v1`', 1, '', '2021-05-25 22:21:54'),
(120, 'create api_key table v2', 'CREATE TABLE IF NOT EXISTS `api_key` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:55'),
(121, 'create index IDX_api_key_org_id - v2', 'CREATE INDEX `IDX_api_key_org_id` ON `api_key` (`org_id`);', 1, '', '2021-05-25 22:21:55'),
(122, 'create index UQE_api_key_key - v2', 'CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);', 1, '', '2021-05-25 22:21:56'),
(123, 'create index UQE_api_key_org_id_name - v2', 'CREATE UNIQUE INDEX `UQE_api_key_org_id_name` ON `api_key` (`org_id`,`name`);', 1, '', '2021-05-25 22:21:56'),
(124, 'copy api_key v1 to v2', 'INSERT INTO `api_key` (`created`\n, `updated`\n, `id`\n, `org_id`\n, `name`\n, `key`\n, `role`) SELECT `created`\n, `updated`\n, `id`\n, `account_id`\n, `name`\n, `key`\n, `role` FROM `api_key_v1`', 1, '', '2021-05-25 22:21:57'),
(125, 'Drop old table api_key_v1', 'DROP TABLE IF EXISTS `api_key_v1`', 1, '', '2021-05-25 22:21:57'),
(126, 'Update api_key table charset', 'ALTER TABLE `api_key` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:21:57'),
(127, 'Add expires to api_key table', 'alter table `api_key` ADD COLUMN `expires` BIGINT(20) NULL ', 1, '', '2021-05-25 22:21:58'),
(128, 'create dashboard_snapshot table v4', 'CREATE TABLE IF NOT EXISTS `dashboard_snapshot` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `dashboard` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `expires` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:58'),
(129, 'drop table dashboard_snapshot_v4 #1', 'DROP TABLE IF EXISTS `dashboard_snapshot`', 1, '', '2021-05-25 22:21:58'),
(130, 'create dashboard_snapshot table v5 #2', 'CREATE TABLE IF NOT EXISTS `dashboard_snapshot` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `delete_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `external` TINYINT(1) NOT NULL\n, `external_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `dashboard` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `expires` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:21:59'),
(131, 'create index UQE_dashboard_snapshot_key - v5', 'CREATE UNIQUE INDEX `UQE_dashboard_snapshot_key` ON `dashboard_snapshot` (`key`);', 1, '', '2021-05-25 22:21:59'),
(132, 'create index UQE_dashboard_snapshot_delete_key - v5', 'CREATE UNIQUE INDEX `UQE_dashboard_snapshot_delete_key` ON `dashboard_snapshot` (`delete_key`);', 1, '', '2021-05-25 22:22:00'),
(133, 'create index IDX_dashboard_snapshot_user_id - v5', 'CREATE INDEX `IDX_dashboard_snapshot_user_id` ON `dashboard_snapshot` (`user_id`);', 1, '', '2021-05-25 22:22:00'),
(134, 'alter dashboard_snapshot to mediumtext v2', 'ALTER TABLE dashboard_snapshot MODIFY dashboard MEDIUMTEXT;', 1, '', '2021-05-25 22:22:01'),
(135, 'Update dashboard_snapshot table charset', 'ALTER TABLE `dashboard_snapshot` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `delete_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `external_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `dashboard` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:22:03'),
(136, 'Add column external_delete_url to dashboard_snapshots table', 'alter table `dashboard_snapshot` ADD COLUMN `external_delete_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:22:04'),
(137, 'Add encrypted dashboard json column', 'alter table `dashboard_snapshot` ADD COLUMN `dashboard_encrypted` BLOB NULL ', 1, '', '2021-05-25 22:22:04'),
(138, 'Change dashboard_encrypted column to MEDIUMBLOB', 'ALTER TABLE dashboard_snapshot MODIFY dashboard_encrypted MEDIUMBLOB;', 1, '', '2021-05-25 22:22:05'),
(139, 'create quota table v1', 'CREATE TABLE IF NOT EXISTS `quota` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NULL\n, `user_id` BIGINT(20) NULL\n, `target` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `limit` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:06'),
(140, 'create index UQE_quota_org_id_user_id_target - v1', 'CREATE UNIQUE INDEX `UQE_quota_org_id_user_id_target` ON `quota` (`org_id`,`user_id`,`target`);', 1, '', '2021-05-25 22:22:07'),
(141, 'Update quota table charset', 'ALTER TABLE `quota` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `target` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:22:07'),
(142, 'create plugin_setting table', 'CREATE TABLE IF NOT EXISTS `plugin_setting` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NULL\n, `plugin_id` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `enabled` TINYINT(1) NOT NULL\n, `pinned` TINYINT(1) NOT NULL\n, `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:07'),
(143, 'create index UQE_plugin_setting_org_id_plugin_id - v1', 'CREATE UNIQUE INDEX `UQE_plugin_setting_org_id_plugin_id` ON `plugin_setting` (`org_id`,`plugin_id`);', 1, '', '2021-05-25 22:22:08'),
(144, 'Add column plugin_version to plugin_settings', 'alter table `plugin_setting` ADD COLUMN `plugin_version` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:22:08'),
(145, 'Update plugin_setting table charset', 'ALTER TABLE `plugin_setting` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `plugin_id` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `plugin_version` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;', 1, '', '2021-05-25 22:22:09'),
(146, 'create session table', 'CREATE TABLE IF NOT EXISTS `session` (\n`key` CHAR(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `data` BLOB NOT NULL\n, `expiry` INTEGER(255) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:09'),
(147, 'Drop old table playlist table', 'DROP TABLE IF EXISTS `playlist`', 1, '', '2021-05-25 22:22:10'),
(148, 'Drop old table playlist_item table', 'DROP TABLE IF EXISTS `playlist_item`', 1, '', '2021-05-25 22:22:10'),
(149, 'create playlist table v2', 'CREATE TABLE IF NOT EXISTS `playlist` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:10'),
(150, 'create playlist item table v2', 'CREATE TABLE IF NOT EXISTS `playlist_item` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `playlist_id` BIGINT(20) NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `order` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:11'),
(151, 'Update playlist table charset', 'ALTER TABLE `playlist` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `interval` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:22:11'),
(152, 'Update playlist_item table charset', 'ALTER TABLE `playlist_item` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:22:12'),
(153, 'drop preferences table v2', 'DROP TABLE IF EXISTS `preferences`', 1, '', '2021-05-25 22:22:12'),
(154, 'drop preferences table v3', 'DROP TABLE IF EXISTS `preferences`', 1, '', '2021-05-25 22:22:12'),
(155, 'create preferences table v3', 'CREATE TABLE IF NOT EXISTS `preferences` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `home_dashboard_id` BIGINT(20) NOT NULL\n, `timezone` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `theme` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:12'),
(156, 'Update preferences table charset', 'ALTER TABLE `preferences` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `timezone` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `theme` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:22:13'),
(157, 'Add column team_id in preferences', 'alter table `preferences` ADD COLUMN `team_id` BIGINT(20) NULL ', 1, '', '2021-05-25 22:22:13'),
(158, 'Update team_id column values in preferences', 'UPDATE preferences SET team_id=0 WHERE team_id IS NULL;', 1, '', '2021-05-25 22:22:13'),
(159, 'create alert table v1', 'CREATE TABLE IF NOT EXISTS `alert` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `panel_id` BIGINT(20) NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `frequency` BIGINT(20) NOT NULL\n, `handler` BIGINT(20) NOT NULL\n, `severity` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `silenced` TINYINT(1) NOT NULL\n, `execution_error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `eval_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `eval_date` DATETIME NULL\n, `new_state_date` DATETIME NOT NULL\n, `state_changes` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:14'),
(160, 'add index alert org_id & id ', 'CREATE INDEX `IDX_alert_org_id_id` ON `alert` (`org_id`,`id`);', 1, '', '2021-05-25 22:22:14'),
(161, 'add index alert state', 'CREATE INDEX `IDX_alert_state` ON `alert` (`state`);', 1, '', '2021-05-25 22:22:15'),
(162, 'add index alert dashboard_id', 'CREATE INDEX `IDX_alert_dashboard_id` ON `alert` (`dashboard_id`);', 1, '', '2021-05-25 22:22:15'),
(163, 'Create alert_rule_tag table v1', 'CREATE TABLE IF NOT EXISTS `alert_rule_tag` (\n`alert_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:16'),
(164, 'Add unique index alert_rule_tag.alert_id_tag_id', 'CREATE UNIQUE INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag` (`alert_id`,`tag_id`);', 1, '', '2021-05-25 22:22:16'),
(165, 'drop index UQE_alert_rule_tag_alert_id_tag_id - v1', 'DROP INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag`', 1, '', '2021-05-25 22:22:17'),
(166, 'Rename table alert_rule_tag to alert_rule_tag_v1 - v1', 'ALTER TABLE `alert_rule_tag` RENAME TO `alert_rule_tag_v1`', 1, '', '2021-05-25 22:22:18'),
(167, 'Create alert_rule_tag table v2', 'CREATE TABLE IF NOT EXISTS `alert_rule_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:19'),
(168, 'create index UQE_alert_rule_tag_alert_id_tag_id - Add unique index alert_rule_tag.alert_id_tag_id V2', 'CREATE UNIQUE INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag` (`alert_id`,`tag_id`);', 1, '', '2021-05-25 22:22:19'),
(169, 'copy alert_rule_tag v1 to v2', 'INSERT INTO `alert_rule_tag` (`tag_id`\n, `alert_id`) SELECT `tag_id`\n, `alert_id` FROM `alert_rule_tag_v1`', 1, '', '2021-05-25 22:22:20'),
(170, 'drop table alert_rule_tag_v1', 'DROP TABLE IF EXISTS `alert_rule_tag_v1`', 1, '', '2021-05-25 22:22:20'),
(171, 'create alert_notification table v1', 'CREATE TABLE IF NOT EXISTS `alert_notification` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:20'),
(172, 'Add column is_default', 'alter table `alert_notification` ADD COLUMN `is_default` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:22:21'),
(173, 'Add column frequency', 'alter table `alert_notification` ADD COLUMN `frequency` BIGINT(20) NULL ', 1, '', '2021-05-25 22:22:22'),
(174, 'Add column send_reminder', 'alter table `alert_notification` ADD COLUMN `send_reminder` TINYINT(1) NULL DEFAULT 0 ', 1, '', '2021-05-25 22:22:22'),
(175, 'Add column disable_resolve_message', 'alter table `alert_notification` ADD COLUMN `disable_resolve_message` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:22:22'),
(176, 'add index alert_notification org_id & name', 'CREATE UNIQUE INDEX `UQE_alert_notification_org_id_name` ON `alert_notification` (`org_id`,`name`);', 1, '', '2021-05-25 22:22:23'),
(177, 'Update alert table charset', 'ALTER TABLE `alert` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `severity` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `execution_error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `eval_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;', 1, '', '2021-05-25 22:22:24'),
(178, 'Update alert_notification table charset', 'ALTER TABLE `alert_notification` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:22:24'),
(179, 'create notification_journal table v1', 'CREATE TABLE IF NOT EXISTS `alert_notification_journal` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `notifier_id` BIGINT(20) NOT NULL\n, `sent_at` BIGINT(20) NOT NULL\n, `success` TINYINT(1) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:24'),
(180, 'add index notification_journal org_id & alert_id & notifier_id', 'CREATE INDEX `IDX_alert_notification_journal_org_id_alert_id_notifier_id` ON `alert_notification_journal` (`org_id`,`alert_id`,`notifier_id`);', 1, '', '2021-05-25 22:22:25'),
(181, 'drop alert_notification_journal', 'DROP TABLE IF EXISTS `alert_notification_journal`', 1, '', '2021-05-25 22:22:25'),
(182, 'create alert_notification_state table v1', 'CREATE TABLE IF NOT EXISTS `alert_notification_state` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `notifier_id` BIGINT(20) NOT NULL\n, `state` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `updated_at` BIGINT(20) NOT NULL\n, `alert_rule_state_updated_version` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:26'),
(183, 'add index alert_notification_state org_id & alert_id & notifier_id', 'CREATE UNIQUE INDEX `UQE_alert_notification_state_org_id_alert_id_notifier_id` ON `alert_notification_state` (`org_id`,`alert_id`,`notifier_id`);', 1, '', '2021-05-25 22:22:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES
(184, 'Add for to alert table', 'alter table `alert` ADD COLUMN `for` BIGINT(20) NULL ', 1, '', '2021-05-25 22:22:27'),
(185, 'Add column uid in alert_notification', 'alter table `alert_notification` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:22:27'),
(186, 'Update uid column values in alert_notification', 'UPDATE alert_notification SET uid=lpad(id,9,\'0\') WHERE uid IS NULL;', 1, '', '2021-05-25 22:22:28'),
(187, 'Add unique index alert_notification_org_id_uid', 'CREATE UNIQUE INDEX `UQE_alert_notification_org_id_uid` ON `alert_notification` (`org_id`,`uid`);', 1, '', '2021-05-25 22:22:28'),
(188, 'Remove unique index org_id_name', 'DROP INDEX `UQE_alert_notification_org_id_name` ON `alert_notification`', 1, '', '2021-05-25 22:22:29'),
(189, 'Add column secure_settings in alert_notification', 'alter table `alert_notification` ADD COLUMN `secure_settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:22:29'),
(190, 'alter alert.settings to mediumtext', 'ALTER TABLE alert MODIFY settings MEDIUMTEXT;', 1, '', '2021-05-25 22:22:30'),
(191, 'Add non-unique index alert_notification_state_alert_id', 'CREATE INDEX `IDX_alert_notification_state_alert_id` ON `alert_notification_state` (`alert_id`);', 1, '', '2021-05-25 22:22:33'),
(192, 'Add non-unique index alert_rule_tag_alert_id', 'CREATE INDEX `IDX_alert_rule_tag_alert_id` ON `alert_rule_tag` (`alert_id`);', 1, '', '2021-05-25 22:22:34'),
(193, 'Drop old annotation table v4', 'DROP TABLE IF EXISTS `annotation`', 1, '', '2021-05-25 22:22:35'),
(194, 'create annotation table v5', 'CREATE TABLE IF NOT EXISTS `annotation` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NULL\n, `user_id` BIGINT(20) NULL\n, `dashboard_id` BIGINT(20) NULL\n, `panel_id` BIGINT(20) NULL\n, `category_id` BIGINT(20) NULL\n, `type` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `text` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `metric` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `prev_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `new_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `epoch` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:35'),
(195, 'add index annotation 0 v3', 'CREATE INDEX `IDX_annotation_org_id_alert_id` ON `annotation` (`org_id`,`alert_id`);', 1, '', '2021-05-25 22:22:35'),
(196, 'add index annotation 1 v3', 'CREATE INDEX `IDX_annotation_org_id_type` ON `annotation` (`org_id`,`type`);', 1, '', '2021-05-25 22:22:36'),
(197, 'add index annotation 2 v3', 'CREATE INDEX `IDX_annotation_org_id_category_id` ON `annotation` (`org_id`,`category_id`);', 1, '', '2021-05-25 22:22:38'),
(198, 'add index annotation 3 v3', 'CREATE INDEX `IDX_annotation_org_id_dashboard_id_panel_id_epoch` ON `annotation` (`org_id`,`dashboard_id`,`panel_id`,`epoch`);', 1, '', '2021-05-25 22:22:39'),
(199, 'add index annotation 4 v3', 'CREATE INDEX `IDX_annotation_org_id_epoch` ON `annotation` (`org_id`,`epoch`);', 1, '', '2021-05-25 22:22:40'),
(200, 'Update annotation table charset', 'ALTER TABLE `annotation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `text` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `metric` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `prev_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `new_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2021-05-25 22:22:41'),
(201, 'Add column region_id to annotation table', 'alter table `annotation` ADD COLUMN `region_id` BIGINT(20) NULL DEFAULT 0 ', 1, '', '2021-05-25 22:22:41'),
(202, 'Drop category_id index', 'DROP INDEX `IDX_annotation_org_id_category_id` ON `annotation`', 1, '', '2021-05-25 22:22:42'),
(203, 'Add column tags to annotation table', 'alter table `annotation` ADD COLUMN `tags` VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:22:42'),
(204, 'Create annotation_tag table v2', 'CREATE TABLE IF NOT EXISTS `annotation_tag` (\n`annotation_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:43'),
(205, 'Add unique index annotation_tag.annotation_id_tag_id', 'CREATE UNIQUE INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag` (`annotation_id`,`tag_id`);', 1, '', '2021-05-25 22:22:45'),
(206, 'drop index UQE_annotation_tag_annotation_id_tag_id - v2', 'DROP INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag`', 1, '', '2021-05-25 22:22:47'),
(207, 'Rename table annotation_tag to annotation_tag_v2 - v2', 'ALTER TABLE `annotation_tag` RENAME TO `annotation_tag_v2`', 1, '', '2021-05-25 22:22:49'),
(208, 'Create annotation_tag table v3', 'CREATE TABLE IF NOT EXISTS `annotation_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `annotation_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:22:49'),
(209, 'create index UQE_annotation_tag_annotation_id_tag_id - Add unique index annotation_tag.annotation_id_tag_id V3', 'CREATE UNIQUE INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag` (`annotation_id`,`tag_id`);', 1, '', '2021-05-25 22:22:50'),
(210, 'copy annotation_tag v2 to v3', 'INSERT INTO `annotation_tag` (`tag_id`\n, `annotation_id`) SELECT `tag_id`\n, `annotation_id` FROM `annotation_tag_v2`', 1, '', '2021-05-25 22:22:51'),
(211, 'drop table annotation_tag_v2', 'DROP TABLE IF EXISTS `annotation_tag_v2`', 1, '', '2021-05-25 22:22:52'),
(212, 'Update alert annotations and set TEXT to empty', 'UPDATE annotation SET TEXT = \'\' WHERE alert_id > 0', 1, '', '2021-05-25 22:22:54'),
(213, 'Add created time to annotation table', 'alter table `annotation` ADD COLUMN `created` BIGINT(20) NULL DEFAULT 0 ', 1, '', '2021-05-25 22:22:54'),
(214, 'Add updated time to annotation table', 'alter table `annotation` ADD COLUMN `updated` BIGINT(20) NULL DEFAULT 0 ', 1, '', '2021-05-25 22:22:55'),
(215, 'Add index for created in annotation table', 'CREATE INDEX `IDX_annotation_org_id_created` ON `annotation` (`org_id`,`created`);', 1, '', '2021-05-25 22:22:55'),
(216, 'Add index for updated in annotation table', 'CREATE INDEX `IDX_annotation_org_id_updated` ON `annotation` (`org_id`,`updated`);', 1, '', '2021-05-25 22:22:56'),
(217, 'Convert existing annotations from seconds to milliseconds', 'UPDATE annotation SET epoch = (epoch*1000) where epoch < 9999999999', 1, '', '2021-05-25 22:22:57'),
(218, 'Add epoch_end column', 'alter table `annotation` ADD COLUMN `epoch_end` BIGINT(20) NOT NULL DEFAULT 0 ', 1, '', '2021-05-25 22:22:57'),
(219, 'Add index for epoch_end', 'CREATE INDEX `IDX_annotation_org_id_epoch_epoch_end` ON `annotation` (`org_id`,`epoch`,`epoch_end`);', 1, '', '2021-05-25 22:22:57'),
(220, 'Make epoch_end the same as epoch', 'UPDATE annotation SET epoch_end = epoch', 1, '', '2021-05-25 22:22:58'),
(221, 'Move region to single row', 'code migration', 1, '', '2021-05-25 22:22:58'),
(222, 'Remove index org_id_epoch from annotation table', 'DROP INDEX `IDX_annotation_org_id_epoch` ON `annotation`', 1, '', '2021-05-25 22:22:58'),
(223, 'Remove index org_id_dashboard_id_panel_id_epoch from annotation table', 'DROP INDEX `IDX_annotation_org_id_dashboard_id_panel_id_epoch` ON `annotation`', 1, '', '2021-05-25 22:22:58'),
(224, 'Add index for org_id_dashboard_id_epoch_end_epoch on annotation table', 'CREATE INDEX `IDX_annotation_org_id_dashboard_id_epoch_end_epoch` ON `annotation` (`org_id`,`dashboard_id`,`epoch_end`,`epoch`);', 1, '', '2021-05-25 22:22:58'),
(225, 'Add index for org_id_epoch_end_epoch on annotation table', 'CREATE INDEX `IDX_annotation_org_id_epoch_end_epoch` ON `annotation` (`org_id`,`epoch_end`,`epoch`);', 1, '', '2021-05-25 22:22:59'),
(226, 'Remove index org_id_epoch_epoch_end from annotation table', 'DROP INDEX `IDX_annotation_org_id_epoch_epoch_end` ON `annotation`', 1, '', '2021-05-25 22:23:00'),
(227, 'Add index for alert_id on annotation table', 'CREATE INDEX `IDX_annotation_alert_id` ON `annotation` (`alert_id`);', 1, '', '2021-05-25 22:23:00'),
(228, 'create test_data table', 'CREATE TABLE IF NOT EXISTS `test_data` (\n`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `metric1` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `metric2` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `value_big_int` BIGINT(20) NULL\n, `value_double` DOUBLE NULL\n, `value_float` FLOAT NULL\n, `value_int` INT NULL\n, `time_epoch` BIGINT(20) NOT NULL\n, `time_date_time` DATETIME NOT NULL\n, `time_time_stamp` TIMESTAMP NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:01'),
(229, 'create dashboard_version table v1', 'CREATE TABLE IF NOT EXISTS `dashboard_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n, `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:01'),
(230, 'add index dashboard_version.dashboard_id', 'CREATE INDEX `IDX_dashboard_version_dashboard_id` ON `dashboard_version` (`dashboard_id`);', 1, '', '2021-05-25 22:23:02'),
(231, 'add unique index dashboard_version.dashboard_id and dashboard_version.version', 'CREATE UNIQUE INDEX `UQE_dashboard_version_dashboard_id_version` ON `dashboard_version` (`dashboard_id`,`version`);', 1, '', '2021-05-25 22:23:02'),
(232, 'Set dashboard version to 1 where 0', 'UPDATE dashboard SET version = 1 WHERE version = 0', 1, '', '2021-05-25 22:23:03'),
(233, 'save existing dashboard data in dashboard_version table v1', 'INSERT INTO dashboard_version\n(\n	dashboard_id,\n	version,\n	parent_version,\n	restored_from,\n	created,\n	created_by,\n	message,\n	data\n)\nSELECT\n	dashboard.id,\n	dashboard.version,\n	dashboard.version,\n	dashboard.version,\n	dashboard.updated,\n	COALESCE(dashboard.updated_by, -1),\n	\'\',\n	dashboard.data\nFROM dashboard;', 1, '', '2021-05-25 22:23:03'),
(234, 'alter dashboard_version.data to mediumtext v1', 'ALTER TABLE dashboard_version MODIFY data MEDIUMTEXT;', 1, '', '2021-05-25 22:23:03'),
(235, 'create team table', 'CREATE TABLE IF NOT EXISTS `team` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:04'),
(236, 'add index team.org_id', 'CREATE INDEX `IDX_team_org_id` ON `team` (`org_id`);', 1, '', '2021-05-25 22:23:04'),
(237, 'add unique index team_org_id_name', 'CREATE UNIQUE INDEX `UQE_team_org_id_name` ON `team` (`org_id`,`name`);', 1, '', '2021-05-25 22:23:05'),
(238, 'create team member table', 'CREATE TABLE IF NOT EXISTS `team_member` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `team_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:05'),
(239, 'add index team_member.org_id', 'CREATE INDEX `IDX_team_member_org_id` ON `team_member` (`org_id`);', 1, '', '2021-05-25 22:23:06'),
(240, 'add unique index team_member_org_id_team_id_user_id', 'CREATE UNIQUE INDEX `UQE_team_member_org_id_team_id_user_id` ON `team_member` (`org_id`,`team_id`,`user_id`);', 1, '', '2021-05-25 22:23:06'),
(241, 'add index team_member.team_id', 'CREATE INDEX `IDX_team_member_team_id` ON `team_member` (`team_id`);', 1, '', '2021-05-25 22:23:07'),
(242, 'Add column email to team table', 'alter table `team` ADD COLUMN `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:23:07'),
(243, 'Add column external to team_member table', 'alter table `team_member` ADD COLUMN `external` TINYINT(1) NULL ', 1, '', '2021-05-25 22:23:07'),
(244, 'Add column permission to team_member table', 'alter table `team_member` ADD COLUMN `permission` SMALLINT NULL ', 1, '', '2021-05-25 22:23:08'),
(245, 'create dashboard acl table', 'CREATE TABLE IF NOT EXISTS `dashboard_acl` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NULL\n, `team_id` BIGINT(20) NULL\n, `permission` SMALLINT NOT NULL DEFAULT 4\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:08'),
(246, 'add index dashboard_acl_dashboard_id', 'CREATE INDEX `IDX_dashboard_acl_dashboard_id` ON `dashboard_acl` (`dashboard_id`);', 1, '', '2021-05-25 22:23:09'),
(247, 'add unique index dashboard_acl_dashboard_id_user_id', 'CREATE UNIQUE INDEX `UQE_dashboard_acl_dashboard_id_user_id` ON `dashboard_acl` (`dashboard_id`,`user_id`);', 1, '', '2021-05-25 22:23:09'),
(248, 'add unique index dashboard_acl_dashboard_id_team_id', 'CREATE UNIQUE INDEX `UQE_dashboard_acl_dashboard_id_team_id` ON `dashboard_acl` (`dashboard_id`,`team_id`);', 1, '', '2021-05-25 22:23:09'),
(249, 'save default acl rules in dashboard_acl table', '\nINSERT INTO dashboard_acl\n	(\n		org_id,\n		dashboard_id,\n		permission,\n		role,\n		created,\n		updated\n	)\n	VALUES\n		(-1,-1, 1,\'Viewer\',\'2017-06-20\',\'2017-06-20\'),\n		(-1,-1, 2,\'Editor\',\'2017-06-20\',\'2017-06-20\')\n	', 1, '', '2021-05-25 22:23:10'),
(250, 'delete acl rules for deleted dashboards and folders', 'DELETE FROM dashboard_acl WHERE dashboard_id NOT IN (SELECT id FROM dashboard) AND dashboard_id != -1', 1, '', '2021-05-25 22:23:10'),
(251, 'create tag table', 'CREATE TABLE IF NOT EXISTS `tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `key` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:10'),
(252, 'add index tag.key_value', 'CREATE UNIQUE INDEX `UQE_tag_key_value` ON `tag` (`key`,`value`);', 1, '', '2021-05-25 22:23:10'),
(253, 'create login attempt table', 'CREATE TABLE IF NOT EXISTS `login_attempt` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `username` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `ip_address` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:11'),
(254, 'add index login_attempt.username', 'CREATE INDEX `IDX_login_attempt_username` ON `login_attempt` (`username`);', 1, '', '2021-05-25 22:23:11'),
(255, 'drop index IDX_login_attempt_username - v1', 'DROP INDEX `IDX_login_attempt_username` ON `login_attempt`', 1, '', '2021-05-25 22:23:11'),
(256, 'Rename table login_attempt to login_attempt_tmp_qwerty - v1', 'ALTER TABLE `login_attempt` RENAME TO `login_attempt_tmp_qwerty`', 1, '', '2021-05-25 22:23:12'),
(257, 'create login_attempt v2', 'CREATE TABLE IF NOT EXISTS `login_attempt` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `username` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `ip_address` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:12'),
(258, 'create index IDX_login_attempt_username - v2', 'CREATE INDEX `IDX_login_attempt_username` ON `login_attempt` (`username`);', 1, '', '2021-05-25 22:23:13'),
(259, 'copy login_attempt v1 to v2', 'INSERT INTO `login_attempt` (`id`\n, `username`\n, `ip_address`) SELECT `id`\n, `username`\n, `ip_address` FROM `login_attempt_tmp_qwerty`', 1, '', '2021-05-25 22:23:13'),
(260, 'drop login_attempt_tmp_qwerty', 'DROP TABLE IF EXISTS `login_attempt_tmp_qwerty`', 1, '', '2021-05-25 22:23:13'),
(261, 'create user auth table', 'CREATE TABLE IF NOT EXISTS `user_auth` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `auth_module` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `auth_id` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:13'),
(262, 'create index IDX_user_auth_auth_module_auth_id - v1', 'CREATE INDEX `IDX_user_auth_auth_module_auth_id` ON `user_auth` (`auth_module`,`auth_id`);', 1, '', '2021-05-25 22:23:14'),
(263, 'alter user_auth.auth_id to length 190', 'ALTER TABLE user_auth MODIFY auth_id VARCHAR(190);', 1, '', '2021-05-25 22:23:14'),
(264, 'Add OAuth access token to user_auth', 'alter table `user_auth` ADD COLUMN `o_auth_access_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:23:15'),
(265, 'Add OAuth refresh token to user_auth', 'alter table `user_auth` ADD COLUMN `o_auth_refresh_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:23:15'),
(266, 'Add OAuth token type to user_auth', 'alter table `user_auth` ADD COLUMN `o_auth_token_type` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2021-05-25 22:23:16'),
(267, 'Add OAuth expiry to user_auth', 'alter table `user_auth` ADD COLUMN `o_auth_expiry` DATETIME NULL ', 1, '', '2021-05-25 22:23:16'),
(268, 'Add index to user_id column in user_auth', 'CREATE INDEX `IDX_user_auth_user_id` ON `user_auth` (`user_id`);', 1, '', '2021-05-25 22:23:16'),
(269, 'create server_lock table', 'CREATE TABLE IF NOT EXISTS `server_lock` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `operation_uid` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `last_execution` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:17'),
(270, 'add index server_lock.operation_uid', 'CREATE UNIQUE INDEX `UQE_server_lock_operation_uid` ON `server_lock` (`operation_uid`);', 1, '', '2021-05-25 22:23:17'),
(271, 'create user auth token table', 'CREATE TABLE IF NOT EXISTS `user_auth_token` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `auth_token` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `prev_auth_token` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `user_agent` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `client_ip` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `auth_token_seen` TINYINT(1) NOT NULL\n, `seen_at` INT NULL\n, `rotated_at` INT NOT NULL\n, `created_at` INT NOT NULL\n, `updated_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:18'),
(272, 'add unique index user_auth_token.auth_token', 'CREATE UNIQUE INDEX `UQE_user_auth_token_auth_token` ON `user_auth_token` (`auth_token`);', 1, '', '2021-05-25 22:23:18'),
(273, 'add unique index user_auth_token.prev_auth_token', 'CREATE UNIQUE INDEX `UQE_user_auth_token_prev_auth_token` ON `user_auth_token` (`prev_auth_token`);', 1, '', '2021-05-25 22:23:19'),
(274, 'add index user_auth_token.user_id', 'CREATE INDEX `IDX_user_auth_token_user_id` ON `user_auth_token` (`user_id`);', 1, '', '2021-05-25 22:23:19'),
(275, 'Add revoked_at to the user auth token', 'alter table `user_auth_token` ADD COLUMN `revoked_at` INT NULL ', 1, '', '2021-05-25 22:23:20'),
(276, 'create cache_data table', 'CREATE TABLE IF NOT EXISTS `cache_data` (\n`cache_key` VARCHAR(168) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `data` BLOB NOT NULL\n, `expires` INTEGER(255) NOT NULL\n, `created_at` INTEGER(255) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:20'),
(277, 'add unique index cache_data.cache_key', 'CREATE UNIQUE INDEX `UQE_cache_data_cache_key` ON `cache_data` (`cache_key`);', 1, '', '2021-05-25 22:23:20'),
(278, 'create short_url table v1', 'CREATE TABLE IF NOT EXISTS `short_url` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `path` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_by` INT NOT NULL\n, `created_at` INT NOT NULL\n, `last_seen_at` INT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2021-05-25 22:23:21'),
(279, 'add index short_url.org_id-uid', 'CREATE UNIQUE INDEX `UQE_short_url_org_id_uid` ON `short_url` (`org_id`,`uid`);', 1, '', '2021-05-25 22:23:21'),
(280, 'delete alert_definition table', 'DROP TABLE IF EXISTS `alert_definition`', 1, '', '2022-07-05 19:05:16'),
(281, 'recreate alert_definition table', 'CREATE TABLE IF NOT EXISTS `alert_definition` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL DEFAULT 60\n, `version` INT NOT NULL DEFAULT 0\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-07-05 19:05:16'),
(282, 'add index in alert_definition on org_id and title columns', 'CREATE INDEX `IDX_alert_definition_org_id_title` ON `alert_definition` (`org_id`,`title`);', 1, '', '2022-07-05 19:05:16'),
(283, 'add index in alert_definition on org_id and uid columns', 'CREATE INDEX `IDX_alert_definition_org_id_uid` ON `alert_definition` (`org_id`,`uid`);', 1, '', '2022-07-05 19:05:16'),
(284, 'alter alert_definition table data column to mediumtext in mysql', 'ALTER TABLE alert_definition MODIFY data MEDIUMTEXT;', 1, '', '2022-07-05 19:05:16'),
(285, 'drop index in alert_definition on org_id and title columns', 'DROP INDEX `IDX_alert_definition_org_id_title` ON `alert_definition`', 1, '', '2022-07-05 19:05:16'),
(286, 'drop index in alert_definition on org_id and uid columns', 'DROP INDEX `IDX_alert_definition_org_id_uid` ON `alert_definition`', 1, '', '2022-07-05 19:05:16'),
(287, 'add unique index in alert_definition on org_id and title columns', 'CREATE UNIQUE INDEX `UQE_alert_definition_org_id_title` ON `alert_definition` (`org_id`,`title`);', 1, '', '2022-07-05 19:05:16'),
(288, 'add unique index in alert_definition on org_id and uid columns', 'CREATE UNIQUE INDEX `UQE_alert_definition_org_id_uid` ON `alert_definition` (`org_id`,`uid`);', 1, '', '2022-07-05 19:05:16'),
(289, 'Add column paused in alert_definition', 'alter table `alert_definition` ADD COLUMN `paused` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2022-07-05 19:05:16'),
(290, 'drop alert_definition table', 'DROP TABLE IF EXISTS `alert_definition`', 1, '', '2022-07-05 19:05:16'),
(291, 'delete alert_definition_version table', 'DROP TABLE IF EXISTS `alert_definition_version`', 1, '', '2022-07-05 19:05:16'),
(292, 'recreate alert_definition_version table', 'CREATE TABLE IF NOT EXISTS `alert_definition_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alert_definition_id` BIGINT(20) NOT NULL\n, `alert_definition_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-07-05 19:05:16'),
(293, 'add index in alert_definition_version table on alert_definition_id and version columns', 'CREATE UNIQUE INDEX `UQE_alert_definition_version_alert_definition_id_version` ON `alert_definition_version` (`alert_definition_id`,`version`);', 1, '', '2022-07-05 19:05:16'),
(294, 'add index in alert_definition_version table on alert_definition_uid and version columns', 'CREATE UNIQUE INDEX `UQE_alert_definition_version_alert_definition_uid_version` ON `alert_definition_version` (`alert_definition_uid`,`version`);', 1, '', '2022-07-05 19:05:16'),
(295, 'alter alert_definition_version table data column to mediumtext in mysql', 'ALTER TABLE alert_definition_version MODIFY data MEDIUMTEXT;', 1, '', '2022-07-05 19:05:16'),
(296, 'drop alert_definition_version table', 'DROP TABLE IF EXISTS `alert_definition_version`', 1, '', '2022-07-05 19:05:16'),
(297, 'create alert_instance table', 'CREATE TABLE IF NOT EXISTS `alert_instance` (\n`def_org_id` BIGINT(20) NOT NULL\n, `def_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `labels_hash` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `current_state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `current_state_since` BIGINT(20) NOT NULL\n, `last_eval_time` BIGINT(20) NOT NULL\n, PRIMARY KEY ( `def_org_id`,`def_uid`,`labels_hash` )) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-07-05 19:05:16'),
(298, 'add index in alert_instance table on def_org_id, def_uid and current_state columns', 'CREATE INDEX `IDX_alert_instance_def_org_id_def_uid_current_state` ON `alert_instance` (`def_org_id`,`def_uid`,`current_state`);', 1, '', '2022-07-05 19:05:16'),
(299, 'add index in alert_instance table on def_org_id, current_state columns', 'CREATE INDEX `IDX_alert_instance_def_org_id_current_state` ON `alert_instance` (`def_org_id`,`current_state`);', 1, '', '2022-07-05 19:05:16'),
(300, 'add column current_state_end to alert_instance', 'alter table `alert_instance` ADD COLUMN `current_state_end` BIGINT(20) NOT NULL DEFAULT 0 ', 1, '', '2022-07-05 19:05:16'),
(301, 'remove index def_org_id, def_uid, current_state on alert_instance', 'DROP INDEX `IDX_alert_instance_def_org_id_def_uid_current_state` ON `alert_instance`', 1, '', '2022-07-05 19:05:16'),
(302, 'remove index def_org_id, current_state on alert_instance', 'DROP INDEX `IDX_alert_instance_def_org_id_current_state` ON `alert_instance`', 1, '', '2022-07-05 19:05:16'),
(303, 'rename def_org_id to rule_org_id in alert_instance', 'ALTER TABLE alert_instance CHANGE def_org_id rule_org_id BIGINT;', 1, '', '2022-07-05 19:05:16'),
(304, 'rename def_uid to rule_uid in alert_instance', 'ALTER TABLE alert_instance CHANGE def_uid rule_uid VARCHAR(40);', 1, '', '2022-07-05 19:05:16'),
(305, 'add index rule_org_id, rule_uid, current_state on alert_instance', 'CREATE INDEX `IDX_alert_instance_rule_org_id_rule_uid_current_state` ON `alert_instance` (`rule_org_id`,`rule_uid`,`current_state`);', 1, '', '2022-07-05 19:05:16'),
(306, 'add index rule_org_id, current_state on alert_instance', 'CREATE INDEX `IDX_alert_instance_rule_org_id_current_state` ON `alert_instance` (`rule_org_id`,`current_state`);', 1, '', '2022-07-05 19:05:16'),
(307, 'create alert_rule table', 'CREATE TABLE IF NOT EXISTS `alert_rule` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL DEFAULT 60\n, `version` INT NOT NULL DEFAULT 0\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `namespace_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `rule_group` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `no_data_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'NoData\'\n, `exec_err_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'Alerting\'\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-07-05 19:05:17'),
(308, 'add index in alert_rule on org_id and title columns', 'CREATE UNIQUE INDEX `UQE_alert_rule_org_id_title` ON `alert_rule` (`org_id`,`title`);', 1, '', '2022-07-05 19:05:17'),
(309, 'add index in alert_rule on org_id and uid columns', 'CREATE UNIQUE INDEX `UQE_alert_rule_org_id_uid` ON `alert_rule` (`org_id`,`uid`);', 1, '', '2022-07-05 19:05:17'),
(310, 'add index in alert_rule on org_id, namespace_uid, group_uid columns', 'CREATE INDEX `IDX_alert_rule_org_id_namespace_uid_rule_group` ON `alert_rule` (`org_id`,`namespace_uid`,`rule_group`);', 1, '', '2022-07-05 19:05:17'),
(311, 'alter alert_rule table data column to mediumtext in mysql', 'ALTER TABLE alert_rule MODIFY data MEDIUMTEXT;', 1, '', '2022-07-05 19:05:17'),
(312, 'add column for to alert_rule', 'alter table `alert_rule` ADD COLUMN `for` BIGINT(20) NOT NULL DEFAULT 0 ', 1, '', '2022-07-05 19:05:17'),
(313, 'add column annotations to alert_rule', 'alter table `alert_rule` ADD COLUMN `annotations` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-07-05 19:05:17'),
(314, 'add column labels to alert_rule', 'alter table `alert_rule` ADD COLUMN `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-07-05 19:05:17'),
(315, 'remove unique index from alert_rule on org_id, title columns', 'DROP INDEX `UQE_alert_rule_org_id_title` ON `alert_rule`', 1, '', '2022-07-05 19:05:17'),
(316, 'add index in alert_rule on org_id, namespase_uid and title columns', 'CREATE UNIQUE INDEX `UQE_alert_rule_org_id_namespace_uid_title` ON `alert_rule` (`org_id`,`namespace_uid`,`title`);', 1, '', '2022-07-05 19:05:17'),
(317, 'create alert_rule_version table', 'CREATE TABLE IF NOT EXISTS `alert_rule_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `rule_org_id` BIGINT(20) NOT NULL\n, `rule_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `rule_namespace_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `rule_group` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL\n, `no_data_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'NoData\'\n, `exec_err_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'Alerting\'\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-07-05 19:05:17'),
(318, 'add index in alert_rule_version table on rule_org_id, rule_uid and version columns', 'CREATE UNIQUE INDEX `UQE_alert_rule_version_rule_org_id_rule_uid_version` ON `alert_rule_version` (`rule_org_id`,`rule_uid`,`version`);', 1, '', '2022-07-05 19:05:17'),
(319, 'add index in alert_rule_version table on rule_org_id, rule_namespace_uid and rule_group columns', 'CREATE INDEX `IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group` ON `alert_rule_version` (`rule_org_id`,`rule_namespace_uid`,`rule_group`);', 1, '', '2022-07-05 19:05:17'),
(320, 'alter alert_rule_version table data column to mediumtext in mysql', 'ALTER TABLE alert_rule_version MODIFY data MEDIUMTEXT;', 1, '', '2022-07-05 19:05:17'),
(321, 'add column for to alert_rule_version', 'alter table `alert_rule_version` ADD COLUMN `for` BIGINT(20) NOT NULL DEFAULT 0 ', 1, '', '2022-07-05 19:05:17'),
(322, 'add column annotations to alert_rule_version', 'alter table `alert_rule_version` ADD COLUMN `annotations` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-07-05 19:05:17'),
(323, 'add column labels to alert_rule_version', 'alter table `alert_rule_version` ADD COLUMN `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-07-05 19:05:17'),
(324, 'create_alert_configuration_table', 'CREATE TABLE IF NOT EXISTS `alert_configuration` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alertmanager_configuration` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `configuration_version` VARCHAR(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-07-05 19:05:17'),
(325, 'Add column default in alert_configuration', 'alter table `alert_configuration` ADD COLUMN `default` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2022-07-05 19:05:17'),
(326, 'alert alert_configuration alertmanager_configuration column from TEXT to MEDIUMTEXT if mysql', 'ALTER TABLE alert_configuration MODIFY alertmanager_configuration MEDIUMTEXT;', 1, '', '2022-07-05 19:05:17'),
(327, 'create library_element table v1', 'CREATE TABLE IF NOT EXISTS `library_element` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `folder_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `kind` BIGINT(20) NOT NULL\n, `type` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `description` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `model` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n, `updated` DATETIME NOT NULL\n, `updated_by` BIGINT(20) NOT NULL\n, `version` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-07-05 19:05:17'),
(328, 'add index library_element org_id-folder_id-name-kind', 'CREATE UNIQUE INDEX `UQE_library_element_org_id_folder_id_name_kind` ON `library_element` (`org_id`,`folder_id`,`name`,`kind`);', 1, '', '2022-07-05 19:05:17'),
(329, 'create library_element_connection table v1', 'CREATE TABLE IF NOT EXISTS `library_element_connection` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `element_id` BIGINT(20) NOT NULL\n, `kind` BIGINT(20) NOT NULL\n, `connection_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-07-05 19:05:17'),
(330, 'add index library_element_connection element_id-kind-connection_id', 'CREATE UNIQUE INDEX `UQE_library_element_connection_element_id_kind_connection_id` ON `library_element_connection` (`element_id`,`kind`,`connection_id`);', 1, '', '2022-07-05 19:05:17'),
(331, 'Add is_service_account column to user', 'alter table `user` ADD COLUMN `is_service_account` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2022-08-01 20:50:53'),
(332, 'Update is_service_account column to nullable', 'ALTER TABLE user MODIFY is_service_account BOOLEAN DEFAULT 0;', 1, '', '2022-08-01 20:50:53'),
(333, 'create index IDX_org_user_user_id - v1', 'CREATE INDEX `IDX_org_user_user_id` ON `org_user` (`user_id`);', 1, '', '2022-08-01 20:50:53'),
(334, 'Add index for dashboard_is_folder', 'CREATE INDEX `IDX_dashboard_is_folder` ON `dashboard` (`is_folder`);', 1, '', '2022-08-01 20:50:54'),
(335, 'Add isPublic for dashboard', 'alter table `dashboard` ADD COLUMN `is_public` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2022-08-01 20:50:54'),
(336, 'Add service account foreign key', 'alter table `api_key` ADD COLUMN `service_account_id` BIGINT(20) NULL ', 1, '', '2022-08-01 20:50:54'),
(337, 'set service account foreign key to nil if 0', 'UPDATE api_key SET service_account_id = NULL WHERE service_account_id = 0;', 1, '', '2022-08-01 20:50:54'),
(338, 'Add column week_start in preferences', 'alter table `preferences` ADD COLUMN `week_start` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-08-01 20:50:54'),
(339, 'Add column preferences.json_data', 'alter table `preferences` ADD COLUMN `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-08-01 20:50:54'),
(340, 'alter preferences.json_data to mediumtext v1', 'ALTER TABLE preferences MODIFY json_data MEDIUMTEXT;', 1, '', '2022-08-01 20:50:54'),
(341, 'add index dashboard_acl_user_id', 'CREATE INDEX `IDX_dashboard_acl_user_id` ON `dashboard_acl` (`user_id`);', 1, '', '2022-08-01 20:50:54'),
(342, 'add index dashboard_acl_team_id', 'CREATE INDEX `IDX_dashboard_acl_team_id` ON `dashboard_acl` (`team_id`);', 1, '', '2022-08-01 20:50:54'),
(343, 'add index dashboard_acl_org_id_role', 'CREATE INDEX `IDX_dashboard_acl_org_id_role` ON `dashboard_acl` (`org_id`,`role`);', 1, '', '2022-08-01 20:50:54'),
(344, 'add index dashboard_permission', 'CREATE INDEX `IDX_dashboard_acl_permission` ON `dashboard_acl` (`permission`);', 1, '', '2022-08-01 20:50:54'),
(345, 'Add OAuth ID token to user_auth', 'alter table `user_auth` ADD COLUMN `o_auth_id_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-08-01 20:50:54'),
(346, 'add current_reason column related to current_state', 'alter table `alert_instance` ADD COLUMN `current_reason` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-08-01 20:50:54'),
(347, 'add dashboard_uid column to alert_rule', 'alter table `alert_rule` ADD COLUMN `dashboard_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-08-01 20:50:54'),
(348, 'add panel_id column to alert_rule', 'alter table `alert_rule` ADD COLUMN `panel_id` BIGINT(20) NULL ', 1, '', '2022-08-01 20:50:54'),
(349, 'add index in alert_rule on org_id, dashboard_uid and panel_id columns', 'CREATE INDEX `IDX_alert_rule_org_id_dashboard_uid_panel_id` ON `alert_rule` (`org_id`,`dashboard_uid`,`panel_id`);', 1, '', '2022-08-01 20:50:54'),
(350, 'add column org_id in alert_configuration', 'alter table `alert_configuration` ADD COLUMN `org_id` BIGINT(20) NOT NULL DEFAULT 0 ', 1, '', '2022-08-01 20:50:54'),
(351, 'add index in alert_configuration table on org_id column', 'CREATE INDEX `IDX_alert_configuration_org_id` ON `alert_configuration` (`org_id`);', 1, '', '2022-08-01 20:50:54'),
(352, 'add configuration_hash column to alert_configuration', 'alter table `alert_configuration` ADD COLUMN `configuration_hash` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'not-yet-calculated\' ', 1, '', '2022-08-01 20:50:54'),
(353, 'create_ngalert_configuration_table', 'CREATE TABLE IF NOT EXISTS `ngalert_configuration` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alertmanagers` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created_at` INT NOT NULL\n, `updated_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(354, 'add index in ngalert_configuration on org_id column', 'CREATE UNIQUE INDEX `UQE_ngalert_configuration_org_id` ON `ngalert_configuration` (`org_id`);', 1, '', '2022-08-01 20:50:54'),
(355, 'add column send_alerts_to in ngalert_configuration', 'alter table `ngalert_configuration` ADD COLUMN `send_alerts_to` SMALLINT NOT NULL DEFAULT 0 ', 1, '', '2022-08-01 20:50:54'),
(356, 'create provenance_type table', 'CREATE TABLE IF NOT EXISTS `provenance_type` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `record_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `record_type` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `provenance` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(357, 'add index to uniquify (record_key, record_type, org_id) columns', 'CREATE UNIQUE INDEX `UQE_provenance_type_record_type_record_key_org_id` ON `provenance_type` (`record_type`,`record_key`,`org_id`);', 1, '', '2022-08-01 20:50:54'),
(358, 'create alert_image table', 'CREATE TABLE IF NOT EXISTS `alert_image` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `token` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `path` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `url` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_at` DATETIME NOT NULL\n, `expires_at` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(359, 'add unique index on token to alert_image table', 'CREATE UNIQUE INDEX `UQE_alert_image_token` ON `alert_image` (`token`);', 1, '', '2022-08-01 20:50:54'),
(360, 'move dashboard alerts to unified alerting', 'code migration', 1, '', '2022-08-01 20:50:54'),
(361, 'add unique index library_element org_id_uid', 'CREATE UNIQUE INDEX `UQE_library_element_org_id_uid` ON `library_element` (`org_id`,`uid`);', 1, '', '2022-08-01 20:50:54'),
(362, 'increase max description length to 2048', 'ALTER TABLE `library_element` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `description` VARCHAR(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;', 1, '', '2022-08-01 20:50:54'),
(363, 'clone move dashboard alerts to unified alerting', 'code migration', 1, '', '2022-08-01 20:50:54'),
(364, 'create data_keys table', 'CREATE TABLE IF NOT EXISTS `data_keys` (\n`name` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `active` TINYINT(1) NOT NULL\n, `scope` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `provider` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `encrypted_data` BLOB NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(365, 'create secrets table', 'CREATE TABLE IF NOT EXISTS `secrets` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `namespace` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(366, 'rename data_keys name column to id', 'ALTER TABLE `data_keys` CHANGE `name` `id` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci', 1, '', '2022-08-01 20:50:54'),
(367, 'add name column into data_keys', 'alter table `data_keys` ADD COLUMN `name` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'\' ', 1, '', '2022-08-01 20:50:54'),
(368, 'copy data_keys id column values into name', 'UPDATE data_keys SET name = id', 1, '', '2022-08-01 20:50:54'),
(369, 'rename data_keys name column to label', 'ALTER TABLE `data_keys` CHANGE `name` `label` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci', 1, '', '2022-08-01 20:50:54'),
(370, 'rename data_keys id column back to name', 'ALTER TABLE `data_keys` CHANGE `id` `name` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci', 1, '', '2022-08-01 20:50:54'),
(371, 'create kv_store table v1', 'CREATE TABLE IF NOT EXISTS `kv_store` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `namespace` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(372, 'add index kv_store.org_id-namespace-key', 'CREATE UNIQUE INDEX `UQE_kv_store_org_id_namespace_key` ON `kv_store` (`org_id`,`namespace`,`key`);', 1, '', '2022-08-01 20:50:54'),
(373, 'update dashboard_uid and panel_id from existing annotations', 'set dashboard_uid and panel_id migration', 1, '', '2022-08-01 20:50:54'),
(374, 'create permission table', 'CREATE TABLE IF NOT EXISTS `permission` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `action` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `scope` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(375, 'add unique index permission.role_id', 'CREATE INDEX `IDX_permission_role_id` ON `permission` (`role_id`);', 1, '', '2022-08-01 20:50:54'),
(376, 'add unique index role_id_action_scope', 'CREATE UNIQUE INDEX `UQE_permission_role_id_action_scope` ON `permission` (`role_id`,`action`,`scope`);', 1, '', '2022-08-01 20:50:54'),
(377, 'create role table', 'CREATE TABLE IF NOT EXISTS `role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `description` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `version` BIGINT(20) NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(378, 'add column display_name', 'alter table `role` ADD COLUMN `display_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-08-01 20:50:54'),
(379, 'add column group_name', 'alter table `role` ADD COLUMN `group_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ', 1, '', '2022-08-01 20:50:54'),
(380, 'add index role.org_id', 'CREATE INDEX `IDX_role_org_id` ON `role` (`org_id`);', 1, '', '2022-08-01 20:50:54'),
(381, 'add unique index role_org_id_name', 'CREATE UNIQUE INDEX `UQE_role_org_id_name` ON `role` (`org_id`,`name`);', 1, '', '2022-08-01 20:50:54'),
(382, 'add index role_org_id_uid', 'CREATE UNIQUE INDEX `UQE_role_org_id_uid` ON `role` (`org_id`,`uid`);', 1, '', '2022-08-01 20:50:54'),
(383, 'create team role table', 'CREATE TABLE IF NOT EXISTS `team_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `team_id` BIGINT(20) NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(384, 'add index team_role.org_id', 'CREATE INDEX `IDX_team_role_org_id` ON `team_role` (`org_id`);', 1, '', '2022-08-01 20:50:54'),
(385, 'add unique index team_role_org_id_team_id_role_id', 'CREATE UNIQUE INDEX `UQE_team_role_org_id_team_id_role_id` ON `team_role` (`org_id`,`team_id`,`role_id`);', 1, '', '2022-08-01 20:50:54'),
(386, 'add index team_role.team_id', 'CREATE INDEX `IDX_team_role_team_id` ON `team_role` (`team_id`);', 1, '', '2022-08-01 20:50:54'),
(387, 'create user role table', 'CREATE TABLE IF NOT EXISTS `user_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(388, 'add index user_role.org_id', 'CREATE INDEX `IDX_user_role_org_id` ON `user_role` (`org_id`);', 1, '', '2022-08-01 20:50:54'),
(389, 'add unique index user_role_org_id_user_id_role_id', 'CREATE UNIQUE INDEX `UQE_user_role_org_id_user_id_role_id` ON `user_role` (`org_id`,`user_id`,`role_id`);', 1, '', '2022-08-01 20:50:54'),
(390, 'add index user_role.user_id', 'CREATE INDEX `IDX_user_role_user_id` ON `user_role` (`user_id`);', 1, '', '2022-08-01 20:50:54');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES
(391, 'create builtin role table', 'CREATE TABLE IF NOT EXISTS `builtin_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `role` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(392, 'add index builtin_role.role_id', 'CREATE INDEX `IDX_builtin_role_role_id` ON `builtin_role` (`role_id`);', 1, '', '2022-08-01 20:50:54'),
(393, 'add index builtin_role.name', 'CREATE INDEX `IDX_builtin_role_role` ON `builtin_role` (`role`);', 1, '', '2022-08-01 20:50:54'),
(394, 'Add column org_id to builtin_role table', 'alter table `builtin_role` ADD COLUMN `org_id` BIGINT(20) NOT NULL DEFAULT 0 ', 1, '', '2022-08-01 20:50:54'),
(395, 'add index builtin_role.org_id', 'CREATE INDEX `IDX_builtin_role_org_id` ON `builtin_role` (`org_id`);', 1, '', '2022-08-01 20:50:54'),
(396, 'add unique index builtin_role_org_id_role_id_role', 'CREATE UNIQUE INDEX `UQE_builtin_role_org_id_role_id_role` ON `builtin_role` (`org_id`,`role_id`,`role`);', 1, '', '2022-08-01 20:50:54'),
(397, 'Remove unique index role_org_id_uid', 'DROP INDEX `UQE_role_org_id_uid` ON `role`', 1, '', '2022-08-01 20:50:54'),
(398, 'add unique index role.uid', 'CREATE UNIQUE INDEX `UQE_role_uid` ON `role` (`uid`);', 1, '', '2022-08-01 20:50:54'),
(399, 'create seed assignment table', 'CREATE TABLE IF NOT EXISTS `seed_assignment` (\n`builtin_role` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(400, 'add unique index builtin_role_role_name', 'CREATE UNIQUE INDEX `UQE_seed_assignment_builtin_role_role_name` ON `seed_assignment` (`builtin_role`,`role_name`);', 1, '', '2022-08-01 20:50:54'),
(401, 'add column hidden to role table', 'alter table `role` ADD COLUMN `hidden` TINYINT(1) NOT NULL DEFAULT 0 ', 1, '', '2022-08-01 20:50:54'),
(402, 'create query_history table v1', 'CREATE TABLE IF NOT EXISTS `query_history` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `datasource_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_by` INT NOT NULL\n, `created_at` INT NOT NULL\n, `comment` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `queries` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(403, 'add index query_history.org_id-created_by-datasource_uid', 'CREATE INDEX `IDX_query_history_org_id_created_by_datasource_uid` ON `query_history` (`org_id`,`created_by`,`datasource_uid`);', 1, '', '2022-08-01 20:50:54'),
(404, 'teams permissions migration', 'code migration', 1, '', '2022-08-01 20:50:54'),
(405, 'dashboard permissions', 'code migration', 1, '', '2022-08-01 20:50:54'),
(406, 'dashboard permissions uid scopes', 'code migration', 1, '', '2022-08-01 20:50:54'),
(407, 'drop managed folder create actions', 'code migration', 1, '', '2022-08-01 20:50:54'),
(408, 'alerting notification permissions', 'code migration', 1, '', '2022-08-01 20:50:54'),
(409, 'create query_history_star table v1', 'CREATE TABLE IF NOT EXISTS `query_history_star` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `query_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `user_id` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(410, 'add index query_history.user_id-query_uid', 'CREATE UNIQUE INDEX `UQE_query_history_star_user_id_query_uid` ON `query_history_star` (`user_id`,`query_uid`);', 1, '', '2022-08-01 20:50:54'),
(411, 'add column org_id in query_history_star', 'alter table `query_history_star` ADD COLUMN `org_id` BIGINT(20) NOT NULL DEFAULT 1 ', 1, '', '2022-08-01 20:50:54'),
(412, 'create entity_events table', 'CREATE TABLE IF NOT EXISTS `entity_event` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `entity_id` VARCHAR(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `event_type` VARCHAR(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(413, 'create dashboard public config v1', 'CREATE TABLE IF NOT EXISTS `dashboard_public_config` (\n`uid` BIGINT(20) PRIMARY KEY NOT NULL\n, `dashboard_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `refresh_rate` INT NOT NULL DEFAULT 30\n, `template_variables` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `time_variables` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(414, 'create index UQE_dashboard_public_config_uid - v1', 'CREATE UNIQUE INDEX `UQE_dashboard_public_config_uid` ON `dashboard_public_config` (`uid`);', 1, '', '2022-08-01 20:50:54'),
(415, 'create index IDX_dashboard_public_config_org_id_dashboard_uid - v1', 'CREATE INDEX `IDX_dashboard_public_config_org_id_dashboard_uid` ON `dashboard_public_config` (`org_id`,`dashboard_uid`);', 1, '', '2022-08-01 20:50:54'),
(416, 'create default alerting folders', 'code migration', 1, '', '2022-08-01 20:50:54'),
(417, 'create file table', 'CREATE TABLE IF NOT EXISTS `file` (\n`path` VARCHAR(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `path_hash` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `parent_folder_path_hash` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `contents` BLOB NOT NULL\n, `etag` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `cache_control` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `content_disposition` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `size` BIGINT(20) NOT NULL\n, `mime_type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(418, 'file table idx: path natural pk', 'CREATE UNIQUE INDEX `UQE_file_path_hash` ON `file` (`path_hash`);', 1, '', '2022-08-01 20:50:54'),
(419, 'file table idx: parent_folder_path_hash fast folder retrieval', 'CREATE INDEX `IDX_file_parent_folder_path_hash` ON `file` (`parent_folder_path_hash`);', 1, '', '2022-08-01 20:50:54'),
(420, 'create file_meta table', 'CREATE TABLE IF NOT EXISTS `file_meta` (\n`path_hash` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` VARCHAR(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;', 1, '', '2022-08-01 20:50:54'),
(421, 'file table idx: path key', 'CREATE UNIQUE INDEX `UQE_file_meta_path_hash_key` ON `file_meta` (`path_hash`,`key`);', 1, '', '2022-08-01 20:50:54'),
(422, 'set path collation in file table', 'SELECT 0;', 1, '', '2022-08-01 20:50:54'),
(423, 'managed permissions migration', 'code migration', 1, '', '2022-08-01 20:50:54'),
(424, 'managed folder permissions alert actions migration', 'code migration', 1, '', '2022-08-01 20:50:54'),
(425, 'RBAC action name migrator', 'code migration', 1, '', '2022-08-01 20:50:54'),
(426, 'Add UID column to playlist', 'alter table `playlist` ADD COLUMN `uid` VARCHAR(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0 ', 1, '', '2022-08-01 20:50:54'),
(427, 'Update uid column values in playlist', 'UPDATE playlist SET uid=id;', 1, '', '2022-08-01 20:50:55'),
(428, 'Add index for uid in playlist', 'CREATE UNIQUE INDEX `UQE_playlist_org_id_uid` ON `playlist` (`org_id`,`uid`);', 1, '', '2022-08-01 20:50:55');

-- --------------------------------------------------------

--
-- Table structure for table `ngalert_configuration`
--

CREATE TABLE `ngalert_configuration` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `alertmanagers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` int NOT NULL,
  `updated_at` int NOT NULL,
  `send_alerts_to` smallint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `org`
--

CREATE TABLE `org` (
  `id` bigint NOT NULL,
  `version` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `org`
--

INSERT INTO `org` (`id`, `version`, `name`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`, `billing_email`, `created`, `updated`) VALUES
(1, 0, 'Main Org.', '', '', '', '', '', '', NULL, '2021-05-25 22:23:23', '2021-05-25 22:23:23');

-- --------------------------------------------------------

--
-- Table structure for table `org_user`
--

CREATE TABLE `org_user` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `org_user`
--

INSERT INTO `org_user` (`id`, `org_id`, `user_id`, `role`, `created`, `updated`) VALUES
(1, 1, 1, 'Admin', '2021-05-25 22:23:23', '2021-05-25 22:23:23');

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `action` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`id`, `role_id`, `action`, `scope`, `created`, `updated`) VALUES
(1, 1, 'dashboards:read', 'dashboards:uid:h8X96w3Mk', '2022-08-01 20:50:54', '2022-08-01 20:50:54'),
(2, 1, 'dashboards:write', 'dashboards:uid:h8X96w3Mk', '2022-08-01 20:50:54', '2022-08-01 20:50:54'),
(3, 1, 'dashboards:delete', 'dashboards:uid:h8X96w3Mk', '2022-08-01 20:50:54', '2022-08-01 20:50:54'),
(4, 2, 'dashboards:read', 'dashboards:uid:h8X96w3Mk', '2022-08-01 20:50:54', '2022-08-01 20:50:54'),
(5, 3, 'dashboards:delete', 'dashboards:uid:h8X96w3Mk', '2022-08-01 20:50:54', '2022-08-01 20:50:54'),
(6, 3, 'dashboards:read', 'dashboards:uid:h8X96w3Mk', '2022-08-01 20:50:54', '2022-08-01 20:50:54'),
(7, 3, 'dashboards:write', 'dashboards:uid:h8X96w3Mk', '2022-08-01 20:50:54', '2022-08-01 20:50:54');

-- --------------------------------------------------------

--
-- Table structure for table `playlist`
--

CREATE TABLE `playlist` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `uid` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `playlist_item`
--

CREATE TABLE `playlist_item` (
  `id` bigint NOT NULL,
  `playlist_id` bigint NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plugin_setting`
--

CREATE TABLE `plugin_setting` (
  `id` bigint NOT NULL,
  `org_id` bigint DEFAULT NULL,
  `plugin_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `pinned` tinyint(1) NOT NULL,
  `json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `secure_json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `plugin_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `preferences`
--

CREATE TABLE `preferences` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `version` int NOT NULL,
  `home_dashboard_id` bigint NOT NULL,
  `timezone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `team_id` bigint DEFAULT NULL,
  `week_start` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `json_data` mediumtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `provenance_type`
--

CREATE TABLE `provenance_type` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `record_key` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provenance` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `query_history`
--

CREATE TABLE `query_history` (
  `id` bigint NOT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `datasource_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `created_at` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queries` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `query_history_star`
--

CREATE TABLE `query_history_star` (
  `id` bigint NOT NULL,
  `query_uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `org_id` bigint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quota`
--

CREATE TABLE `quota` (
  `id` bigint NOT NULL,
  `org_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `target` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `limit` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` bigint NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `version` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `display_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`, `description`, `version`, `org_id`, `uid`, `created`, `updated`, `display_name`, `group_name`, `hidden`) VALUES
(1, 'managed:builtins:editor:permissions', '', 0, 1, '2sKmF0z4k', '2022-08-01 20:50:54', '2022-08-01 20:50:54', '', '', 0),
(2, 'managed:builtins:viewer:permissions', '', 0, 1, 'TsFiK0z4k', '2022-08-01 20:50:54', '2022-08-01 20:50:54', '', '', 0),
(3, 'managed:builtins:admin:permissions', '', 0, 1, 't9FiF0z4k', '2022-08-01 20:50:54', '2022-08-01 20:50:54', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `secrets`
--

CREATE TABLE `secrets` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `namespace` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `secrets`
--

INSERT INTO `secrets` (`id`, `org_id`, `namespace`, `type`, `value`, `created`, `updated`) VALUES
(1, 1, 'MySQL', 'datasource', 'I1RqUnFiVXRCZWpSNiNsTmtnWmJmZU8HxpTAMYjlR17L8pjk/VGWtdTSw6KlXkd6/u/skc7k/aaU', '2022-08-01 20:51:12', '2022-08-01 20:51:12');

-- --------------------------------------------------------

--
-- Table structure for table `seed_assignment`
--

CREATE TABLE `seed_assignment` (
  `builtin_role` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `server_lock`
--

CREATE TABLE `server_lock` (
  `id` bigint NOT NULL,
  `operation_uid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` bigint NOT NULL,
  `last_execution` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `server_lock`
--

INSERT INTO `server_lock` (`id`, `operation_uid`, `version`, `last_execution`) VALUES
(1, 'cleanup expired auth tokens', 25, 1659387055),
(2, 'delete old login attempts', 1574, 1657048518);

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `key` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` blob NOT NULL,
  `expiry` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `short_url`
--

CREATE TABLE `short_url` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `uid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int NOT NULL,
  `created_at` int NOT NULL,
  `last_seen_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `star`
--

CREATE TABLE `star` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `dashboard_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `id` bigint NOT NULL,
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `id` bigint NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_member`
--

CREATE TABLE `team_member` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `team_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `external` tinyint(1) DEFAULT NULL,
  `permission` smallint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_role`
--

CREATE TABLE `team_role` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `team_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `temp_user`
--

CREATE TABLE `temp_user` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `version` int NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `invited_by_user_id` bigint DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL,
  `email_sent_on` datetime DEFAULT NULL,
  `remote_addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` int NOT NULL DEFAULT '0',
  `updated` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test_data`
--

CREATE TABLE `test_data` (
  `id` int NOT NULL,
  `metric1` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metric2` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_big_int` bigint DEFAULT NULL,
  `value_double` double DEFAULT NULL,
  `value_float` float DEFAULT NULL,
  `value_int` int DEFAULT NULL,
  `time_epoch` bigint NOT NULL,
  `time_date_time` datetime NOT NULL,
  `time_time_stamp` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` bigint NOT NULL,
  `version` int NOT NULL,
  `login` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rands` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `org_id` bigint NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `theme` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `help_flags1` bigint NOT NULL DEFAULT '0',
  `last_seen_at` datetime DEFAULT NULL,
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_service_account` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `version`, `login`, `email`, `name`, `password`, `salt`, `rands`, `company`, `org_id`, `is_admin`, `email_verified`, `theme`, `created`, `updated`, `help_flags1`, `last_seen_at`, `is_disabled`, `is_service_account`) VALUES
(1, 0, 'admin', 'admin@localhost', '', 'b41ae50833ba329102f018590f621fa5157df08ebbb2579d7623961588acdb3afb0a02fa78635b780f085c450130735eed5e', 'mdtyscitLB', 'kfbihpdw4N', '', 1, 1, 0, '', '2021-05-25 22:23:23', '2021-07-01 20:51:18', 0, '2022-08-01 20:51:11', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_auth`
--

CREATE TABLE `user_auth` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `auth_module` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `o_auth_access_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `o_auth_refresh_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `o_auth_token_type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `o_auth_expiry` datetime DEFAULT NULL,
  `o_auth_id_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_auth_token`
--

CREATE TABLE `user_auth_token` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `auth_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prev_auth_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_token_seen` tinyint(1) NOT NULL,
  `seen_at` int DEFAULT NULL,
  `rotated_at` int NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NOT NULL,
  `revoked_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_auth_token`
--

INSERT INTO `user_auth_token` (`id`, `user_id`, `auth_token`, `prev_auth_token`, `user_agent`, `client_ip`, `auth_token_seen`, `seen_at`, `rotated_at`, `created_at`, `updated_at`, `revoked_at`) VALUES
(7, 1, '2eb047cdff33839bbbc148e06cf3fbeb8a74f1c3bff0c0e342f3e4c80e912bfe', '2eb047cdff33839bbbc148e06cf3fbeb8a74f1c3bff0c0e342f3e4c80e912bfe', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.134 Safari/537.36', '172.27.0.1', 1, 1659387071, 1659387070, 1659387070, 1659387070, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` bigint NOT NULL,
  `org_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alert`
--
ALTER TABLE `alert`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_alert_org_id_id` (`org_id`,`id`),
  ADD KEY `IDX_alert_state` (`state`),
  ADD KEY `IDX_alert_dashboard_id` (`dashboard_id`);

--
-- Indexes for table `alert_configuration`
--
ALTER TABLE `alert_configuration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_alert_configuration_org_id` (`org_id`);

--
-- Indexes for table `alert_image`
--
ALTER TABLE `alert_image`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_alert_image_token` (`token`);

--
-- Indexes for table `alert_instance`
--
ALTER TABLE `alert_instance`
  ADD PRIMARY KEY (`rule_org_id`,`rule_uid`,`labels_hash`),
  ADD KEY `IDX_alert_instance_rule_org_id_rule_uid_current_state` (`rule_org_id`,`rule_uid`,`current_state`),
  ADD KEY `IDX_alert_instance_rule_org_id_current_state` (`rule_org_id`,`current_state`);

--
-- Indexes for table `alert_notification`
--
ALTER TABLE `alert_notification`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_alert_notification_org_id_uid` (`org_id`,`uid`);

--
-- Indexes for table `alert_notification_state`
--
ALTER TABLE `alert_notification_state`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_alert_notification_state_org_id_alert_id_notifier_id` (`org_id`,`alert_id`,`notifier_id`),
  ADD KEY `IDX_alert_notification_state_alert_id` (`alert_id`);

--
-- Indexes for table `alert_rule`
--
ALTER TABLE `alert_rule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_alert_rule_org_id_uid` (`org_id`,`uid`),
  ADD UNIQUE KEY `UQE_alert_rule_org_id_namespace_uid_title` (`org_id`,`namespace_uid`,`title`),
  ADD KEY `IDX_alert_rule_org_id_namespace_uid_rule_group` (`org_id`,`namespace_uid`,`rule_group`),
  ADD KEY `IDX_alert_rule_org_id_dashboard_uid_panel_id` (`org_id`,`dashboard_uid`,`panel_id`);

--
-- Indexes for table `alert_rule_tag`
--
ALTER TABLE `alert_rule_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_alert_rule_tag_alert_id_tag_id` (`alert_id`,`tag_id`),
  ADD KEY `IDX_alert_rule_tag_alert_id` (`alert_id`);

--
-- Indexes for table `alert_rule_version`
--
ALTER TABLE `alert_rule_version`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_alert_rule_version_rule_org_id_rule_uid_version` (`rule_org_id`,`rule_uid`,`version`),
  ADD KEY `IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group` (`rule_org_id`,`rule_namespace_uid`,`rule_group`);

--
-- Indexes for table `annotation`
--
ALTER TABLE `annotation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_annotation_org_id_alert_id` (`org_id`,`alert_id`),
  ADD KEY `IDX_annotation_org_id_type` (`org_id`,`type`),
  ADD KEY `IDX_annotation_org_id_created` (`org_id`,`created`),
  ADD KEY `IDX_annotation_org_id_updated` (`org_id`,`updated`),
  ADD KEY `IDX_annotation_org_id_dashboard_id_epoch_end_epoch` (`org_id`,`dashboard_id`,`epoch_end`,`epoch`),
  ADD KEY `IDX_annotation_org_id_epoch_end_epoch` (`org_id`,`epoch_end`,`epoch`),
  ADD KEY `IDX_annotation_alert_id` (`alert_id`);

--
-- Indexes for table `annotation_tag`
--
ALTER TABLE `annotation_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_annotation_tag_annotation_id_tag_id` (`annotation_id`,`tag_id`);

--
-- Indexes for table `api_key`
--
ALTER TABLE `api_key`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_api_key_key` (`key`),
  ADD UNIQUE KEY `UQE_api_key_org_id_name` (`org_id`,`name`),
  ADD KEY `IDX_api_key_org_id` (`org_id`);

--
-- Indexes for table `builtin_role`
--
ALTER TABLE `builtin_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_builtin_role_org_id_role_id_role` (`org_id`,`role_id`,`role`),
  ADD KEY `IDX_builtin_role_role_id` (`role_id`),
  ADD KEY `IDX_builtin_role_role` (`role`),
  ADD KEY `IDX_builtin_role_org_id` (`org_id`);

--
-- Indexes for table `cache_data`
--
ALTER TABLE `cache_data`
  ADD PRIMARY KEY (`cache_key`),
  ADD UNIQUE KEY `UQE_cache_data_cache_key` (`cache_key`);

--
-- Indexes for table `dashboard`
--
ALTER TABLE `dashboard`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_dashboard_org_id_folder_id_title` (`org_id`,`folder_id`,`title`),
  ADD UNIQUE KEY `UQE_dashboard_org_id_uid` (`org_id`,`uid`),
  ADD KEY `IDX_dashboard_org_id` (`org_id`),
  ADD KEY `IDX_dashboard_gnet_id` (`gnet_id`),
  ADD KEY `IDX_dashboard_org_id_plugin_id` (`org_id`,`plugin_id`),
  ADD KEY `IDX_dashboard_title` (`title`),
  ADD KEY `IDX_dashboard_is_folder` (`is_folder`);

--
-- Indexes for table `dashboard_acl`
--
ALTER TABLE `dashboard_acl`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_dashboard_acl_dashboard_id_user_id` (`dashboard_id`,`user_id`),
  ADD UNIQUE KEY `UQE_dashboard_acl_dashboard_id_team_id` (`dashboard_id`,`team_id`),
  ADD KEY `IDX_dashboard_acl_dashboard_id` (`dashboard_id`),
  ADD KEY `IDX_dashboard_acl_user_id` (`user_id`),
  ADD KEY `IDX_dashboard_acl_team_id` (`team_id`),
  ADD KEY `IDX_dashboard_acl_org_id_role` (`org_id`,`role`),
  ADD KEY `IDX_dashboard_acl_permission` (`permission`);

--
-- Indexes for table `dashboard_provisioning`
--
ALTER TABLE `dashboard_provisioning`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_dashboard_provisioning_dashboard_id` (`dashboard_id`),
  ADD KEY `IDX_dashboard_provisioning_dashboard_id_name` (`dashboard_id`,`name`);

--
-- Indexes for table `dashboard_public_config`
--
ALTER TABLE `dashboard_public_config`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `UQE_dashboard_public_config_uid` (`uid`),
  ADD KEY `IDX_dashboard_public_config_org_id_dashboard_uid` (`org_id`,`dashboard_uid`);

--
-- Indexes for table `dashboard_snapshot`
--
ALTER TABLE `dashboard_snapshot`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_dashboard_snapshot_key` (`key`),
  ADD UNIQUE KEY `UQE_dashboard_snapshot_delete_key` (`delete_key`),
  ADD KEY `IDX_dashboard_snapshot_user_id` (`user_id`);

--
-- Indexes for table `dashboard_tag`
--
ALTER TABLE `dashboard_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_dashboard_tag_dashboard_id` (`dashboard_id`);

--
-- Indexes for table `dashboard_version`
--
ALTER TABLE `dashboard_version`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_dashboard_version_dashboard_id_version` (`dashboard_id`,`version`),
  ADD KEY `IDX_dashboard_version_dashboard_id` (`dashboard_id`);

--
-- Indexes for table `data_keys`
--
ALTER TABLE `data_keys`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `data_source`
--
ALTER TABLE `data_source`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_data_source_org_id_name` (`org_id`,`name`),
  ADD UNIQUE KEY `UQE_data_source_org_id_uid` (`org_id`,`uid`),
  ADD KEY `IDX_data_source_org_id` (`org_id`),
  ADD KEY `IDX_data_source_org_id_is_default` (`org_id`,`is_default`);

--
-- Indexes for table `entity_event`
--
ALTER TABLE `entity_event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `file`
--
ALTER TABLE `file`
  ADD UNIQUE KEY `UQE_file_path_hash` (`path_hash`),
  ADD KEY `IDX_file_parent_folder_path_hash` (`parent_folder_path_hash`);

--
-- Indexes for table `file_meta`
--
ALTER TABLE `file_meta`
  ADD UNIQUE KEY `UQE_file_meta_path_hash_key` (`path_hash`,`key`);

--
-- Indexes for table `kv_store`
--
ALTER TABLE `kv_store`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_kv_store_org_id_namespace_key` (`org_id`,`namespace`,`key`);

--
-- Indexes for table `library_element`
--
ALTER TABLE `library_element`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_library_element_org_id_folder_id_name_kind` (`org_id`,`folder_id`,`name`,`kind`),
  ADD UNIQUE KEY `UQE_library_element_org_id_uid` (`org_id`,`uid`);

--
-- Indexes for table `library_element_connection`
--
ALTER TABLE `library_element_connection`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_library_element_connection_element_id_kind_connection_id` (`element_id`,`kind`,`connection_id`);

--
-- Indexes for table `login_attempt`
--
ALTER TABLE `login_attempt`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_login_attempt_username` (`username`);

--
-- Indexes for table `migration_log`
--
ALTER TABLE `migration_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ngalert_configuration`
--
ALTER TABLE `ngalert_configuration`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_ngalert_configuration_org_id` (`org_id`);

--
-- Indexes for table `org`
--
ALTER TABLE `org`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_org_name` (`name`);

--
-- Indexes for table `org_user`
--
ALTER TABLE `org_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_org_user_org_id_user_id` (`org_id`,`user_id`),
  ADD KEY `IDX_org_user_org_id` (`org_id`),
  ADD KEY `IDX_org_user_user_id` (`user_id`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_permission_role_id_action_scope` (`role_id`,`action`,`scope`),
  ADD KEY `IDX_permission_role_id` (`role_id`);

--
-- Indexes for table `playlist`
--
ALTER TABLE `playlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_playlist_org_id_uid` (`org_id`,`uid`);

--
-- Indexes for table `playlist_item`
--
ALTER TABLE `playlist_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plugin_setting`
--
ALTER TABLE `plugin_setting`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_plugin_setting_org_id_plugin_id` (`org_id`,`plugin_id`);

--
-- Indexes for table `preferences`
--
ALTER TABLE `preferences`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provenance_type`
--
ALTER TABLE `provenance_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_provenance_type_record_type_record_key_org_id` (`record_type`,`record_key`,`org_id`);

--
-- Indexes for table `query_history`
--
ALTER TABLE `query_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_query_history_org_id_created_by_datasource_uid` (`org_id`,`created_by`,`datasource_uid`);

--
-- Indexes for table `query_history_star`
--
ALTER TABLE `query_history_star`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_query_history_star_user_id_query_uid` (`user_id`,`query_uid`);

--
-- Indexes for table `quota`
--
ALTER TABLE `quota`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_quota_org_id_user_id_target` (`org_id`,`user_id`,`target`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_role_org_id_name` (`org_id`,`name`),
  ADD UNIQUE KEY `UQE_role_uid` (`uid`),
  ADD KEY `IDX_role_org_id` (`org_id`);

--
-- Indexes for table `secrets`
--
ALTER TABLE `secrets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seed_assignment`
--
ALTER TABLE `seed_assignment`
  ADD UNIQUE KEY `UQE_seed_assignment_builtin_role_role_name` (`builtin_role`,`role_name`);

--
-- Indexes for table `server_lock`
--
ALTER TABLE `server_lock`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_server_lock_operation_uid` (`operation_uid`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `short_url`
--
ALTER TABLE `short_url`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_short_url_org_id_uid` (`org_id`,`uid`);

--
-- Indexes for table `star`
--
ALTER TABLE `star`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_star_user_id_dashboard_id` (`user_id`,`dashboard_id`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_tag_key_value` (`key`,`value`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_team_org_id_name` (`org_id`,`name`),
  ADD KEY `IDX_team_org_id` (`org_id`);

--
-- Indexes for table `team_member`
--
ALTER TABLE `team_member`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_team_member_org_id_team_id_user_id` (`org_id`,`team_id`,`user_id`),
  ADD KEY `IDX_team_member_org_id` (`org_id`),
  ADD KEY `IDX_team_member_team_id` (`team_id`);

--
-- Indexes for table `team_role`
--
ALTER TABLE `team_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_team_role_org_id_team_id_role_id` (`org_id`,`team_id`,`role_id`),
  ADD KEY `IDX_team_role_org_id` (`org_id`),
  ADD KEY `IDX_team_role_team_id` (`team_id`);

--
-- Indexes for table `temp_user`
--
ALTER TABLE `temp_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_temp_user_email` (`email`),
  ADD KEY `IDX_temp_user_org_id` (`org_id`),
  ADD KEY `IDX_temp_user_code` (`code`),
  ADD KEY `IDX_temp_user_status` (`status`);

--
-- Indexes for table `test_data`
--
ALTER TABLE `test_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_user_login` (`login`),
  ADD UNIQUE KEY `UQE_user_email` (`email`),
  ADD KEY `IDX_user_login_email` (`login`,`email`);

--
-- Indexes for table `user_auth`
--
ALTER TABLE `user_auth`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_user_auth_auth_module_auth_id` (`auth_module`,`auth_id`),
  ADD KEY `IDX_user_auth_user_id` (`user_id`);

--
-- Indexes for table `user_auth_token`
--
ALTER TABLE `user_auth_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_user_auth_token_auth_token` (`auth_token`),
  ADD UNIQUE KEY `UQE_user_auth_token_prev_auth_token` (`prev_auth_token`),
  ADD KEY `IDX_user_auth_token_user_id` (`user_id`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQE_user_role_org_id_user_id_role_id` (`org_id`,`user_id`,`role_id`),
  ADD KEY `IDX_user_role_org_id` (`org_id`),
  ADD KEY `IDX_user_role_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alert`
--
ALTER TABLE `alert`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alert_configuration`
--
ALTER TABLE `alert_configuration`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `alert_image`
--
ALTER TABLE `alert_image`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alert_notification`
--
ALTER TABLE `alert_notification`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alert_notification_state`
--
ALTER TABLE `alert_notification_state`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alert_rule`
--
ALTER TABLE `alert_rule`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alert_rule_tag`
--
ALTER TABLE `alert_rule_tag`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alert_rule_version`
--
ALTER TABLE `alert_rule_version`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `annotation`
--
ALTER TABLE `annotation`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `annotation_tag`
--
ALTER TABLE `annotation_tag`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_key`
--
ALTER TABLE `api_key`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `builtin_role`
--
ALTER TABLE `builtin_role`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dashboard`
--
ALTER TABLE `dashboard`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dashboard_acl`
--
ALTER TABLE `dashboard_acl`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dashboard_provisioning`
--
ALTER TABLE `dashboard_provisioning`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dashboard_snapshot`
--
ALTER TABLE `dashboard_snapshot`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dashboard_tag`
--
ALTER TABLE `dashboard_tag`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dashboard_version`
--
ALTER TABLE `dashboard_version`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `data_source`
--
ALTER TABLE `data_source`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `entity_event`
--
ALTER TABLE `entity_event`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kv_store`
--
ALTER TABLE `kv_store`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `library_element`
--
ALTER TABLE `library_element`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `library_element_connection`
--
ALTER TABLE `library_element_connection`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_attempt`
--
ALTER TABLE `login_attempt`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migration_log`
--
ALTER TABLE `migration_log`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=429;

--
-- AUTO_INCREMENT for table `ngalert_configuration`
--
ALTER TABLE `ngalert_configuration`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `org`
--
ALTER TABLE `org`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `org_user`
--
ALTER TABLE `org_user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `playlist`
--
ALTER TABLE `playlist`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `playlist_item`
--
ALTER TABLE `playlist_item`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plugin_setting`
--
ALTER TABLE `plugin_setting`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preferences`
--
ALTER TABLE `preferences`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `provenance_type`
--
ALTER TABLE `provenance_type`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `query_history`
--
ALTER TABLE `query_history`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `query_history_star`
--
ALTER TABLE `query_history_star`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quota`
--
ALTER TABLE `quota`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `secrets`
--
ALTER TABLE `secrets`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `server_lock`
--
ALTER TABLE `server_lock`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `short_url`
--
ALTER TABLE `short_url`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `star`
--
ALTER TABLE `star`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_member`
--
ALTER TABLE `team_member`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_role`
--
ALTER TABLE `team_role`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `temp_user`
--
ALTER TABLE `temp_user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_data`
--
ALTER TABLE `test_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_auth`
--
ALTER TABLE `user_auth`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_auth_token`
--
ALTER TABLE `user_auth_token`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
