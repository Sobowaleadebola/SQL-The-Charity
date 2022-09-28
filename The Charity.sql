-- To view the content of both datasets individually
    SELECT * FROM Donations;
    SELECT * FROM Donors;

 SELECT DISTINCT id FROM Donations 
 WHERE state = 'California';

 SELECT * FROM Donations WHERE id = 1;

-- To view the content of both datasets merged
    SELECT *
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id;

-- To view total number of registered donors and total expected donations
    SELECT COUNT(id) AS donors,
    SUM(donation) AS total_donations
    FROM Donations;

-- To view total number of donors that donated and the total donations gotten by the charity
    SELECT COUNT(d.id) AS donors,
    SUM(donation) AS total_donations
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id
    WHERE donation_frequency != 'Never';
    

--To view gender count ratio of actual donors and total donation
    SELECT gender,
    COUNT(DISTINCT d.id) AS number_of_donors,
    SUM(donation) AS total_donations
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id
    WHERE donation_frequency != 'Never'
    GROUP BY gender
    ORDER BY 2 DESC;

--To view the gender count ratio of donors that pledged to donate but never did.
    SELECT gender,
    COUNT(DISTINCT d.id) AS number_of_donors,
    SUM(donation) AS total_donations
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id
    WHERE donation_frequency = 'Never'
    GROUP BY gender
    ORDER BY 2 DESC;

-- To view all the US states with donors
    SELECT DISTINCT state
    FROM Donations;

-- To view number of donors and total donation per state in descending order
    SELECT state,
    COUNT(DISTINCT d.id) AS number_of_donors,
    SUM(donation) AS total_donations
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id
    WHERE donation_frequency != 'Never'
    GROUP BY state
    ORDER BY 3 DESC;

-- To view number of donors and total donation per job field in descending order
    SELECT job_field,
    COUNT(DISTINCT d.id) AS number_of_donors,
    SUM(donation) AS total_donations
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id
    WHERE donation_frequency != 'Never'
    GROUP BY job_field
    ORDER BY 3 DESC;

-- To view number of donors and total donation per donation frequency in descending order
    SELECT donation_frequency,
    COUNT(DISTINCT d.id) AS number_of_donors,
    SUM(donation) AS total_donations
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id
    GROUP BY donation_frequency
    ORDER BY 2 Desc;

--# To get the number of 'frequent' and 'less frequent' donors and total amount reliazed from each category
    SELECT A.frequency,
    COUNT(B.id) AS number_of_donors,
    SUM(B.donation) AS total_donations
    FROM (SELECT job_field,
    d.id as id,
    donation,
    donation_frequency,
    CASE
    WHEN donation_frequency = 'Never'
    OR donation_frequency ='Once'
    OR donation_frequency = 'Seldom'
    OR donation_frequency = 'Yearly' THEN 'less frequent'
    ELSE 'frequent'
    END AS frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id) A
    JOIN
    (SELECT job_field,
    d.id as id,
    donation,
    donation_frequency,
    CASE
    WHEN donation_frequency = 'Never'
    OR donation_frequency ='Once'
    OR donation_frequency = 'Seldom'
    OR donation_frequency = 'Yearly' THEN 'less frequent'
    ELSE 'frequent'
    END AS frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id) B
    ON A.id = B.id
    GROUP BY A.frequency
    ORDER BY 3 DESC;

-- To view the gender ratio of frequent and less frequent donors and total donations
    SELECT A.gender,
    A.frequency,
    COUNT(B.id) AS number_of_donors,
    SUM(B.donation) AS total_donations
    FROM (SELECT gender,
    d.id as id,
    donation,
    donation_frequency,
    CASE
    WHEN donation_frequency = 'Never'
    OR donation_frequency ='Once'
    OR donation_frequency = 'Seldom'
    OR donation_frequency = 'Yearly' THEN 'less frequent'
    ELSE 'frequent'
    END AS frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id) A
    JOIN
    (SELECT gender,
    d.id as id,
    donation,
    donation_frequency,
    CASE
    WHEN donation_frequency = 'Never'
    OR donation_frequency ='Once'
    OR donation_frequency = 'Seldom'
    OR donation_frequency = 'Yearly' THEN 'less frequent'
    ELSE 'frequent'
    END AS frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id) B
    ON A.id = B.id
    GROUP BY A.gender,A.frequency
    ORDER BY 1;

-- To view the number of frequent and less frequent donors and total donations from the different job fields
    SELECT A.job_field, A.frequency,
    COUNT(B.id) AS number_of_donors,
    SUM(B.donation) AS total_donations
    FROM (SELECT job_field,
    d.id as id,
    donation,
    donation_frequency,
    CASE
    WHEN donation_frequency = 'Never'
    OR donation_frequency ='Once'
    OR donation_frequency = 'Seldom'
    OR donation_frequency = 'Yearly' THEN 'less frequent'
    ELSE 'frequent'
    END AS frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id) A
    JOIN
    (SELECT job_field,
    d.id as id,
    donation,
    donation_frequency,
    CASE
    WHEN donation_frequency = 'Never'
    OR donation_frequency ='Once'
    OR donation_frequency = 'Seldom'
    OR donation_frequency = 'Yearly' THEN 'less frequent'
    ELSE 'frequent'
    END AS frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id) B
    ON A.id = B.id
    GROUP BY A.job_field, A.frequency
    ORDER BY 1;

-- To get information on the top 10 frequent donors based on the value of their donation
    SELECT TOP 10 B.id AS id,
    A.name,
    A.gender,
    A.state,
    A.university,
    A.job_field,
    A.frequency,
    B.donation AS donation
    FROM (SELECT job_field,
    concat (first_name,' ',last_name) AS name,
    d.id AS id,
    gender,
    state,
    university,
    donation,
    donation_frequency,
    CASE
    WHEN donation_frequency = 'Never'
    OR donation_frequency ='Once'
    OR donation_frequency = 'Seldom'
    OR donation_frequency = 'Yearly' THEN 'less frequent'
    ELSE 'frequent'
    END AS frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id) A
    JOIN
    (SELECT job_field,
    concat (first_name,' ',last_name) AS name,
    d.id AS id,
    donation,
    donation_frequency,
    CASE
    WHEN donation_frequency = 'Never'
    OR donation_frequency ='Once'
    OR donation_frequency = 'Seldom'
    OR donation_frequency = 'Yearly' THEN 'less frequent'
    ELSE 'frequent'
    END AS frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id)B
    ON A.id = B.id
    WHERE A.frequency = 'frequent'
    ORDER BY 8 DESC
    --LIMIT 10

--  To view information on donors that pledged to donate but never did.
    SELECT B.id AS id,
    A.name,
    A.gender,
    A.email,
    B.state,
    B.university,
    B.job_field,
    A.donation
    FROM(SELECT d.id as id,
    concat (first_name,' ',last_name) AS name,
    gender,
    email,
    donation,
    donation_frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id)A
    JOIN (SELECT d.id as id,
    state,
    university,
    job_field
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id)B
    ON A.id = B.id
    WHERE A.donation_frequency = 'Never'
    ORDER BY 2;

--  To view the gender count ratio of donors that pledged to donate but never did but acquired a tertiary education.
    SELECT A.gender, COUNT(A.university) AS number_of_donors, SUM(A.donation) AS total_donations
    FROM (SELECT job_field,gender, university,
    d.id as id, donation, donation_frequency
    FROM Donations dd JOIN Donors d
    ON dd.id = d.id
    WHERE university is NOT NULL) A
    JOIN (SELECT job_field,gender, university,
    d.id as id, donation,
    donation_frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id
    WHERE university is NOT NULL) B
    ON A.id = B.id
    WHERE A.donation_frequency = 'Never'
    GROUP BY A.gender;



---Power Bi=---
 
    SELECT dt.id,first_name, last_name, email,gender, donation, donation_frequency, job_field, university, 
    [state],shirt_size, car,second_language,favourite_colour, movie_genre 
    --INTO FullCharity
    FROM Donations dt
    LEFT JOIN Donors d
    ON dt.id = d.id;

SELECT * FROM FullCharity

 SELECT COUNT(DISTINCT id), [state] FROM Donations 
 WHERE state = 'Illinois'
 GROUP BY [state];

 SELECT * FROM Donations WHERE id = 1;

