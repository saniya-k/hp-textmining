# Harry Potter Scripts Text Mining/Sentiment Analysis/Social Network Analysis
The project is used to identify central themes & characters in the movie Harry Potter and Deathly Hallows (part 2) using text mining, social network analysis and sentiment analysis

The analysis is validated against Google Trend search patterns for character before the movie got released vs after it got released.

The project is based on the concepts of data quilting(https://www.tandfonline.com/doi/full/10.1080/23311975.2019.1629095 ) which aims at presenting the analysis of multiple types of data to create a single cohesive deliverable.

-> Text Mining (TextMining.R)
Used to identify key themes & character of the movie. Used custom stop work & wordnet dictionary for preprocessing and lemmatization. The wordcloud indicates key themes to be "Harry", "dead","kill","Neville","Voldemort","Severus" indicating the movie has a dark flavor and displays some of the central characters.

->Social Network Analysis (SocialNetworkAnalysis.R)
Used to study listenerspeaker pairs and dialouge contents based on a communication graph. The graph indicates pair such as (Lily,Petunia,Young Snape) , (Fred ,George) etc are communicating more with each other than any other character. Outputs a 
CommunicationData.csv file which is further analyzed in Tableau to study which pair has more dialogue length & frequency.

->Sentiment Analysis (SentimentAnalysis.R)
The dialogues of the key characters identified in the social network are further analysed using sentiment analysis to see what appeals to the audience most.
It seems character who potrayed negative sentiments (such as Bellatrix , Voldemort) have a higher spike in popularity (300-500)(Source :Google Trends) times more than positive characters. Google trends data also substantiate that character Neville 
has 1000x net popularity increase which maybe due to large number of dialogues given (coming from the social network analysis) or due to higher extremist sentiments such as anger towards the antagonist etc.
