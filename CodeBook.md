#Code book for interpreting the result
The result dataset contains 10299 records for 68 variables. Among all the varaibles, 66 of them are from "feature.txt" and test/train results. Only mean() and std() are available in the result dataset. For each variables please refer to "feature_info.txt".

The other two variables are "activity" and "subjects" respectively. The "activity" is one of the 6 activities monitored, according to "activity_labels.txt", they are

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

And the "subjects" is the id for users. There are 30 subjects, 9 of which participated in test and 21 participated in training data. The result is the combination of all test and train data.

