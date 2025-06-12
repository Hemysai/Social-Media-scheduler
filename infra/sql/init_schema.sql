create table time_dim (
    time_id int auto_increment primary key,
    date Date,
    hour int,
    day_of_week Vachar(15)
);

create TABLE post_dim (
    post_id varchar(50) primary key,
    caption text,
    media_type varchar(50),
    media_type varchar(50),
);

create table user_dim (
    user_id varchar(50) primary key,
    username varchar(100),
    location varchar(100),
);

create table post_metrics_fact (
    fact_id int auto_increment primary key,
    post_id varchar(50),
    user_id varchar(50),
    time_id int,
    likes int,
    reach int,
    FOREIGN KEY (post_id) REFERENCES post_dim(post_id),
    FOREIGN KEY (user_id) REFERENCES user_dim(user_id),
    foreigh key (time_id) references time_dim(time_id),
); 


