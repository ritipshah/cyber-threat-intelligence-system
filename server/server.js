const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.static('public'));



/* -------------------------
   RISK CALCULATION FUNCTION
--------------------------*/

function updateRisk(userId){

    db.query(
        `SELECT COUNT(*) AS failedAttempts
         FROM security_events
         WHERE user_id = ? AND status = 'FAILED'`,
        [userId],
        (err,results)=>{

            if(err){
                console.error(err);
                return;
            }

            let failed = results[0].failedAttempts;

            let risk = failed * 10;

            if(risk > 100) risk = 100;

            db.query(
                'UPDATE risk_scores SET current_score = ? WHERE user_id = ?',
                [risk, userId]
            );

        }
    );

}



/* -------------------------
   ROOT
--------------------------*/

app.get('/', (req,res)=>{
    res.redirect('/login.html');
});



/* -------------------------
   USERS API
--------------------------*/

app.get('/users',(req,res)=>{

    db.query(
        'SELECT * FROM users',
        (err,results)=>{

            if(err){
                console.error(err);
                return res.status(500).send("Database error");
            }

            res.json(results);

        }
    );

});



/* -------------------------
   LOGIN SYSTEM
--------------------------*/

app.post('/login',(req,res)=>{

    const {email,password}=req.body;

    db.query(
        'SELECT * FROM users WHERE email=?',
        [email],
        (err,results)=>{

            if(err){
                console.error(err);
                return res.status(500).send("Database error");
            }


            /* NEW USER → CREATE USER */

            if(results.length===0){

                db.query(
                    'INSERT INTO users (username,email,role) VALUES (?,?,?)',
                    [email.split('@')[0],email,'User'],
                    (err,newUser)=>{

                        if(err){
                            console.error(err);
                            return res.status(500).send("Error creating user");
                        }

                        const userId=newUser.insertId;

                        /* create initial risk score */

                        db.query(
                            'INSERT INTO risk_scores (user_id,current_score) VALUES (?,0)',
                            [userId]
                        );

                        /* log event */

                        db.query(
                            'INSERT INTO security_events (user_id,event_type_id,status) VALUES (?,2,?)',
                            [userId,'SUCCESS']
                        );

                        updateRisk(userId);

                        return res.json({
                            message:"New user created and logged in",
                            user_id:userId
                        });

                    }
                );

            }


            else{

                const user=results[0];

                if(password==="1234"){

                    db.query(
                        'INSERT INTO security_events (user_id,event_type_id,status) VALUES (?,2,?)',
                        [user.user_id,'SUCCESS']
                    );

                    updateRisk(user.user_id);

                    return res.json({
                        message:"Login successful",
                        user:user
                    });

                }

                else{

                    db.query(
                        'INSERT INTO security_events (user_id,event_type_id,status) VALUES (?,1,?)',
                        [user.user_id,'FAILED']
                    );

                    updateRisk(user.user_id);

                    return res.status(401).send("Invalid password");

                }

            }

        }
    );

});



/* -------------------------
   RISK FOR ONE USER
--------------------------*/

app.get('/risk/:userId',(req,res)=>{

    const userId=req.params.userId;

    db.query(
        'SELECT user_id,current_score FROM risk_scores WHERE user_id=?',
        [userId],
        (err,results)=>{

            if(err){
                console.error(err);
                return res.status(500).send("Database error");
            }

            if(results.length===0){
                return res.status(404).send("Risk score not found");
            }

            res.json(results[0]);

        }
    );

});



/* -------------------------
   ALL RISKS
--------------------------*/

app.get('/risks',(req,res)=>{

    db.query(
        `SELECT users.username,risk_scores.current_score
         FROM risk_scores
         JOIN users ON users.user_id=risk_scores.user_id`,
        (err,results)=>{

            if(err){
                console.error(err);
                return res.status(500).send("Database error");
            }

            res.json(results);

        }
    );

});



/* -------------------------
   SECURITY EVENTS
--------------------------*/

app.get('/events',(req,res)=>{

    db.query(
        'SELECT * FROM security_events ORDER BY event_timestamp DESC',
        (err,results)=>{

            if(err){
                console.error(err);
                return res.status(500).send("Database error");
            }

            res.json(results);

        }
    );

});



/* -------------------------
   INCIDENTS
--------------------------*/

app.get('/incidents',(req,res)=>{

    db.query(
        'SELECT * FROM incidents ORDER BY created_at DESC',
        (err,results)=>{

            if(err){
                console.error(err);
                return res.status(500).send("Database error");
            }

            res.json(results);

        }
    );

});



/* -------------------------
   START SERVER
--------------------------*/

app.listen(3000,()=>{
    console.log("🚀 Server running on port 3000");
});