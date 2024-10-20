-- a procedure ComputeAverageScoreForUser that computes and store the average score for a student

DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(
    IN user_id INT
)
BEGIN
    DECLARE total_score INT DEFAULT 0;
    DECLARE projects_count INT DEFAULT 0;
    DECLARE average_score FLOAT DEFAULT 0;

    -- Calculate the total score and the number of projects
    SELECT SUM(score), COUNT(*)
    INTO total_score, projects_count
    FROM corrections
    WHERE user_id = user_id;

    -- Calculate the average score
    IF projects_count > 0 THEN
        SET average_score = total_score / projects_count;
    ELSE
        SET average_score = 0;
    END IF;

    -- Update the user's average score
    UPDATE users
    SET average_score = average_score
    WHERE id = user_id;
END;

//

DELIMITER ;
