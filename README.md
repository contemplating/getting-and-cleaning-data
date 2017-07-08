Repository for the final project in Getting and Cleaning data course.

Contains the summary data of movement tracking measurements, the codebook, and the R-script used to generate the data

* README.md - this file
* activity_subject.csv - the data
* Codebook.md - description of the variabels
* run_analysis.R - the script that was used to run the analysis

The data is a summary of the results of an experiment that measures the output of smartphone movement detection devices.

(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

The test and training data was merged into one dataset. Only the mean and standard deviation measurements where selected.

In the next step the mean measure where taken and averaged over subject and activity. This data is saved in activity_subject.csv 

Jaco van der Plas, July 2017
