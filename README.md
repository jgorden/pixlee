# pixlee

Developed using Ruby 2.2.4. Backend Rails API with an Angular(1.4.5) frontend. I did the FRONTEND perspective of the challenge. You can find it live at https://pixlee-challenge.herokuapp.com/

To run locally fork/clone down and navigate to the project directory.
```bash
bundle
rake db:create
rake db:migrate
```
While still in the projects root directory, create a .env file and populate it with your instagram access token like so:
```Text
ACCESS_TOKEN="YOUR_TOKEN_HERE"
```
And that's it! 
```bash
rails s
```
And it should be running locally.

## Summary

I decided to use Rails for this project due to time constraints. It is just super easy to get an application up and running with Rails, and on the frontend I decided on Angular for similar reasons, though mostly more due to comfort. I know Angular fairly well, and was able to focus more on the challenge than on the technologies. 

As for what I would improve, a ton. The backend I feel is a bit cringe worthy, as I am just recursively spamming the instagram api, making for a pretty slow app. I would probably also want to put a cap on the amount of posts in a collection, as making a search with a popular hash tag is akin to taking a drink from a fire hose. There are also loads of details I skipped, like validations for collections/posts and testing for both the front and back end. The front end I feel is mostly fine, mostly just lacking styles and some more thought when it comes to design. The two areas I would focus on next would be responsiveness and the mobile layout. It currently rigidly jams in six posts per row, though I feel it would probably be better to have it adjust according to screen size. On small screens it looks just awful.