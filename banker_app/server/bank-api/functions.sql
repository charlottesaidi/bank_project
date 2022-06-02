-- Empêcher l'insertion d'un client ou d'un utilisateur en dehors des jours ouvrables
-- Procédure(fonction qui sera appelée dans les deux triggers)
DELIMITER $$
CREATE PROCEDURE throwExceptionIfWeekend()
BEGIN
    SET @today = DAYOFWEEK(NOW());
    SET @current_hour = DATE_FORMAT(NOW(), "%T");
    SET @error_message = 'Vous ne pouvez pas enregistrer de client ou de compte en dehors des jours ouvrés';
    IF (@today = 6 AND @current_hour > '12:00:00')
    OR @today = 7
    OR (@today = 1 AND @current_hour < '12:00:00') THEN
        signal sqlstate '42000' set MESSAGE_TEXT = @error_message;
    END IF;
END

-- Triggers appelant la procédure pour les tables customers et users :
DELIMITER$$
CREATE TRIGGER `preventClientRegistrationOnWE` BEFORE INSERT ON `customers` 
    FOR EACH ROW 
    BEGIN
        CALL throwExceptionIfWeekend();
END

DELIMITER$$
CREATE TRIGGER `preventUserRegistrationOnWE` BEFORE INSERT ON `users` 
    FOR EACH ROW 
    BEGIN
        CALL throwExceptionIfWeekend();
END

----------------------------------------------------------------------------------------

-- Empêcher la modification du taux d'un type de compte en dehors de la période autorisée
DELIMITER $$
CREATE TRIGGER `preventRateChange` BEFORE UPDATE ON `account_types`
    FOR EACH ROW 
    BEGIN
        SELECT start_date, end_date INTO @start_date, @end_date FROM changing_rate_dates ORDER BY changing_rate_dates.id_changing_rate_date DESC LIMIT 1;
        SET @today = NOW();
        SET @error_message = CONCAT('Les taux ne sont changeables que dans la période du ', @start_date, ' au ', @end_date, '.');
        IF @today < @start_date OR @today > @end_date THEN
            signal sqlstate '42000' set MESSAGE_TEXT = @error_message;
        END IF;
END