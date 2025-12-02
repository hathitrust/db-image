#!/usr/bin/env ruby

# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(File.join(__dir__, "..", "lib"))
require "dotenv"
require "logger"
#require "open3"
require "sequel"
#require "tempfile"
require "database"


Dotenv.load "config/env"
LOGGER = Logger.new($stdout)


PREAMBLE = <<~PREAMBLE
USE ht;
LOCK TABLES `ht_institutions` WRITE;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


LOCK TABLES `ht_institutions` WRITE;
/*!40000 ALTER TABLE `ht_institutions` DISABLE KEYS */;
PREAMBLE

POSTAMBLE = <<~POSTAMBLE
/*!40000 ALTER TABLE `ht_institutions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
POSTAMBLE

def quote(str)
  if str.match "'"
    '"' + str + '"'
  else
    "'" + str + "'"
  end
end


connection = HathiTrust::Database.new.connection

puts PREAMBLE
connection[:ht_institutions].order(Sequel.asc(:inst_id)).each do |inst|
  line = "INSERT INTO `ht_institutions` (inst_id, name, domain, us, enabled) VALUES ("
  values = [
    inst[:inst_id] || "",
    inst[:name] || "",
    inst[:domain] || "",
    inst[:us] ? 1 : 0,
    inst[:enabled] ? 1 : 0
  ]
  #puts values.map {|val| "'" + val.to_s + "'"}
  line += values.map do |val|
    if val.is_a?(Integer)
      val
    else
      quote val
    end
  end.join(", ")
  line += ");"
  puts line
end

puts POSTAMBLE

