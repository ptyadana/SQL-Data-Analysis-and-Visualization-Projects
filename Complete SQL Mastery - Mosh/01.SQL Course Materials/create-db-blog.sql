DROP DATABASE IF EXISTS sql_blog;
CREATE DATABASE sql_blog;

USE sql_blog;

CREATE TABLE `posts`
(
  `post_id` int
(11) NOT NULL AUTO_INCREMENT,
  `title` varchar
(255) NOT NULL,
  `body` text NOT NULL,
  `date_published` datetime DEFAULT NULL,
  PRIMARY KEY
(`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO posts
  (title, body, date_published)
VALUES
  ('Handling a Form in React', 'Web applications often need to send data from browser to the backend server. Certainly, the most used way of doing so is through a HTML form, by using text inputs, radio buttons, checkboxes, selects and so on. This remains true in React. Are you looking how to handle forms in React? If so, this article is a great fit for you. Have a good read.', '2019-01-01'),
  ('What JavaScript Framework You Should Learn to Get a Job in 2019?', 'Are you wondering what JavaScript framework or library you should use to land a job in 2019? In this post, I am going to go over a comparison of the most popular JavaScript frameworks that are available today. By the end of this post, you will be ready to pick the right framework to help you land a front-end developer job in 2019.', '2019-03-02'),
  ('Building an Accessible React Modal Component', 'Modal is an overlay on the web-page, but has some standards to follow. WAI-ARIA Authoring Practices are the standards set by W3C. This lets bots and screen-readers know that it is a modal. It is not within the regular flow of the page. We’ll create an awesome react modal using React components.', '2019-01-15'),
  ('Redux Vs. Mobx – What Should I Pick For My Web App?', 'State management is a hard problem to solve in large applications. Redux and Mobx are both external libraries that are popularly used to solve state management problems.', '2019-02-20'),
  ('Stateful and Stateless Components in React', 'Today, we’re going to review what stateful and stateless components are in React, how you can tell the difference, and the complex process of deciding whether to make components stateful or not.', '2019-03-29');



