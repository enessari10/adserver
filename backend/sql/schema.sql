-- MySQL schema for Adserver

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  name VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS campaigns (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  budget DECIMAL(12,2) DEFAULT 0,
  status ENUM('active','paused','archived') DEFAULT 'active',
  start_date DATE NULL,
  end_date DATE NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ads (
  id INT AUTO_INCREMENT PRIMARY KEY,
  campaign_id INT,
  title VARCHAR(255),
  image_url TEXT,
  target_url TEXT,
  platform VARCHAR(100),
  status ENUM('active','paused','archived') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX (campaign_id),
  CONSTRAINT fk_ads_campaigns FOREIGN KEY (campaign_id) REFERENCES campaigns(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS impressions (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  ad_id INT NULL,
  campaign_id INT NULL,
  request_id VARCHAR(64) NULL,
  user_agent TEXT,
  referer TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX (ad_id),
  INDEX (campaign_id),
  INDEX (created_at)
);

CREATE TABLE IF NOT EXISTS clicks (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  ad_id INT NULL,
  campaign_id INT NULL,
  request_id VARCHAR(64) NULL,
  user_agent TEXT,
  referer TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX (ad_id),
  INDEX (campaign_id),
  INDEX (created_at)
);


