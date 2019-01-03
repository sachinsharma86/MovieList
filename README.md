# MovieList

## Summary
Create a Navigation based app that shows the top movies currently playing in US movie theaters.  The application needs to display a table of top movies with descriptions for each movie (title, release date, genre, image).  When a user clicks a movie row, the application will navigate to a details page showing additional details on the selected movie.

## API Calls
Documentation: https://developers.themoviedb.org/3/getting-started
Once you receive your key, you can make requests using the following base url. You will need to replace the api_key with your issued key.

https://api.themoviedb.org/3/movie/76341?api_key={api_key}

| Method        | EndPoint          |
| ------------- | -------------     |
| GET           | /movie/top_rated  |
| GET           | /movie/{movie_id} |
