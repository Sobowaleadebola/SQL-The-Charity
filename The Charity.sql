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

-- To view donors and their total donations after further grouping the frequency of donations into 2 categories 'frequent' and 'less frequent'
--# To get the number of 'frequent' and 'less frequent' donors and total amount reliazed from each category
    SELECT T1.frequency,
    COUNT(T2.id) AS number_of_donors,
    SUM(T2.donation) AS total_donations
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
    ON dd.id = d.id) T1
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
    ON dd.id = d.id) T2
    ON T1.id = T2.id
    GROUP BY T1.frequency
    ORDER BY 3 DESC;

-- To view the gender ratio of frequent and less frequent donors and total donations
    SELECT T1.gender,
    T1.frequency,
    COUNT(T2.id) AS number_of_donors,
    SUM(T2.donation) AS total_donations
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
    ON dd.id = d.id) T1
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
    ON dd.id = d.id) T2
    ON T1.id = T2.id
    GROUP BY T1.gender,T1.frequency
    ORDER BY 1;

-- To view the number of frequent and less frequent donors and total donations from the different job fields
    SELECT T1.job_field, T1.frequency,
    COUNT(T2.id) AS number_of_donors,
    SUM(T2.donation) AS total_donations
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
    ON dd.id = d.id) T1
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
    ON dd.id = d.id) T2
    ON T1.id = T2.id
    GROUP BY T1.job_field, T1.frequency
    ORDER BY 1;

-- To get information on the top 10 frequent donors based on the value of their donation
    SELECT TOP 10 T2.id AS id,
    T1.name,
    T1.gender,
    T1.state,
    T1.university,
    T1.job_field,
    T1.frequency,
    T2.donation AS donation
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
    ON dd.id = d.id) T1
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
    ON dd.id = d.id)T2
    ON T1.id = T2.id
    WHERE T1.frequency = 'frequent'
    ORDER BY 8 DESC
    --LIMIT 10

--  To view information on donors that pledged to donate but never did.
    SELECT T2.id AS id,
    T1.name,
    T1.gender,
    T1.email,
    T2.state,
    T2.university,
    T2.job_field,
    T1.donation
    FROM(SELECT d.id as id,
    concat (first_name,' ',last_name) AS name,
    gender,
    email,
    donation,
    donation_frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id)T1
    JOIN (SELECT d.id as id,
    state,
    university,
    job_field
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id)T2
    ON T1.id = T2.id
    WHERE T1.donation_frequency = 'Never'
    ORDER BY 2;

--  To view the gender count ratio of donors that pledged to donate but never did but acquired a tertiary education.
    SELECT T1.gender, COUNT(T1.university) AS number_of_donors, SUM(T1.donation) AS total_donations
    FROM (SELECT job_field,gender, university,
    d.id as id, donation, donation_frequency
    FROM Donations dd JOIN Donors d
    ON dd.id = d.id
    WHERE university is NOT NULL) T1
    JOIN (SELECT job_field,gender, university,
    d.id as id, donation,
    donation_frequency
    FROM Donations dd
    JOIN Donors d
    ON dd.id = d.id
    WHERE university is NOT NULL) T2
    ON T1.id = T2.id
    WHERE T1.donation_frequency = 'Never'
    GROUP BY T1.gender;




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