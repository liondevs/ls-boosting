ALTER TABLE `users` ADD COLUMN `level` INT(11) NOT NULL DEFAULT '1';
ALTER TABLE `users` ADD COLUMN `lvlpro` INT(11) NOT NULL DEFAULT '0';

--EDIT THIS IF NOT WORKS
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('nitroradio', 'Nitro Radio', 1, 0, 1),
('nitrocash', 'Nitro Cash', 1, 0, 1),
('tunerlaptop', 'Tuner Chip', 1, 0, 1),
('metalscrap', 'Metal Scrap', 1, 0, 1),
('plastic', 'Plastic', 1, 0, 1),
('copper', 'Copper', 1, 0, 1),
('aluminum', 'Aluminum', 1, 0, 1),
('iron', 'Iron', 1, 0, 1),