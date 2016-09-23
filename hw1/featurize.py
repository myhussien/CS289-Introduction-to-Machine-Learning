'''
**************** PLEASE READ ***************

Script that reads in spam and ham messages and converts each training example
into a feature vector

Code intended for UC Berkeley course CS 189/289A: Machine Learning

Requirements:
-scipy ('pip install scipy')

To add your own features, create a function that takes in the raw text and
word frequency dictionary and outputs a int or float. Then add your feature
in the function 'def generate_feature_vector'

The output of your file will be a .mat file. The data will be accessible using
the following keys:
    -'training_data'
    -'training_labels'
    -'test_data'

Please direct any bugs to kevintee@berkeley.edu
'''

from collections import defaultdict
import glob
import re
import scipy.io

NUM_TRAINING_EXAMPLES = 5172
NUM_TEST_EXAMPLES = 5857

BASE_DIR = './'
SPAM_DIR = 'spam/'
HAM_DIR = 'ham/'
TEST_DIR = 'test/'

# ************* Features *************

# Features that look for certain words
def freq_pain_feature(text, freq):
    return float(freq['pain'])

def freq_private_feature(text, freq):
    return float(freq['private'])

def freq_bank_feature(text, freq):
    return float(freq['bank'])

def freq_money_feature(text, freq):
    return float(freq['money'])

def freq_drug_feature(text, freq):
    return float(freq['drug'])

def freq_spam_feature(text, freq):
    return float(freq['spam'])

def freq_prescription_feature(text, freq):
    return float(freq['prescription'])

def freq_creative_feature(text, freq):
    return float(freq['creative'])

def freq_height_feature(text, freq):
    return float(freq['height'])

def freq_featured_feature(text, freq):
    return float(freq['featured'])

def freq_differ_feature(text, freq):
    return float(freq['differ'])

def freq_width_feature(text, freq):
    return float(freq['width'])

def freq_other_feature(text, freq):
    return float(freq['other'])

def freq_energy_feature(text, freq):
    return float(freq['energy'])

def freq_business_feature(text, freq):
    return float(freq['business'])

def freq_message_feature(text, freq):
    return float(freq['message'])

def freq_volumes_feature(text, freq):
    return float(freq['volumes'])

def freq_revision_feature(text, freq):
    return float(freq['revision'])

def freq_path_feature(text, freq):
    return float(freq['path'])

def freq_meter_feature(text, freq):
    return float(freq['meter'])

def freq_memo_feature(text, freq):
    return float(freq['memo'])

def freq_planning_feature(text, freq):
    return float(freq['planning'])

def freq_pleased_feature(text, freq):
    return float(freq['pleased'])

def freq_record_feature(text, freq):
    return float(freq['record'])

def freq_out_feature(text, freq):
    return float(freq['out'])

# Features that look for certain characters
def freq_semicolon_feature(text, freq):
    return text.count(';')

def freq_dollar_feature(text, freq):
    return text.count('$')

def freq_sharp_feature(text, freq):
    return text.count('#')

def freq_exclamation_feature(text, freq):
    return text.count('!')

def freq_para_feature(text, freq):
    return text.count('(')

def freq_bracket_feature(text, freq):
    return text.count('[')

def freq_and_feature(text, freq):
    return text.count('&')

# --------- Add your own feature methods ----------
def example_feature(text, freq):
    return int('example' in text)
def http_feature(text, freq):
    return int('http' in text)
def www_feature(text, freq):
    return int('www' in text)
def link_feature(text,freq):
    return int('link' in text)
def discount_feature(text,freq):
    return int('discount' in text)
def specials_feature(text,freq):
    return int('specials' in text)
def cost_feature(text,freq):
    return int('cost' in text)
def earn_feature(text,freq):
    return int('earn' in text)
def free_feature(text,freq):
    return int('free' in text)
def luxury_feature(text,freq):
    return int('luxury' in text)
def guaranteed_feature(text,freq):
    return int('guaranteed' in text)
def website_feature(text,freq):
    return int('website' in text)
def investment_feature(text,freq):
    return int('investment' in text)
def edu_feature(text,freq):
    return int('edu' in text)
def snoring_feature(text,freq):
    return int('snor' in text)
def loss_feature(text,freq):
    return int('loss' in text)
def valium_feature(text,freq):
    return int('valium' in text)
def viagra_feature(text,freq):
    return int('viagra' in text)
def vicodin_feature(text,freq):
    return int('vicodin' in text)
def dear_feature(text,freq):
    return int('dear' in text)
def url_feature(text,freq):
    return int('url' in text)
def price_feature(text,freq):
    return int('price' in text)
def meeting_feature(text,freq):
    return int('meeting' in text)
def re_feature(text,freq):
    return int('re :' in text)
def regards_feature(text,freq):
    return int('regards' in text)
def dollar_feature(text, freq):
    return int('dollar' in text)
def hello_feature(text,freq):
    return int('hello' in text)
def best_feature(text,freq):
    return int('best' in text)
def deal_feature(text,freq):
    return int('deal' in text)
def sales_feature(text,freq):
    return int('sales' in text)
def cash_feature(text,freq):
    return int('cash' in text)
def bonus_feature(text,freq):
    return int('bonus' in text)
def cheap_feature(text,freq):
    return int('cheap' in text)
def rate_feature(text,freq):
    return int('rate' in text)
def preview_feature(text,freq):
    return int('preview' in text)
def order_feature(text,freq):
    return int('order' in text)
def membership_feature(text,freq):
    return int('membership' in text)
def click_feature(text,freq):
    return int('click' in text)
def insurance_feature(text,freq):
    return int('insurance' in text)
def resume_feature(text,freq):
    return int('resume' in text)
def conference_feature(text,freq):
    return int('conference' in text)
def thanks_feature(text,freq):
    return int('thanks' in text)
def investment_feature(text,freq):
    return int('investment' in text)
def dolsign_feature(text,freq):
    return int('$' in text)
def fyi_feature(text,freq):
    return int('fyi' in text)
def cc_feature(text,freq):
    return int('cc: ' in text)
# Generates a feature vector
def generate_feature_vector(text, freq):
    feature = []
    feature.append(freq_pain_feature(text, freq))
    feature.append(freq_private_feature(text, freq))
    feature.append(freq_bank_feature(text, freq))
    feature.append(freq_money_feature(text, freq))
    feature.append(freq_drug_feature(text, freq))
    feature.append(freq_spam_feature(text, freq))
    feature.append(freq_prescription_feature(text, freq))
    feature.append(freq_creative_feature(text, freq))
    feature.append(freq_height_feature(text, freq))
    feature.append(freq_featured_feature(text, freq))
    feature.append(freq_differ_feature(text, freq))
    feature.append(freq_width_feature(text, freq))
    feature.append(freq_other_feature(text, freq))
    feature.append(freq_energy_feature(text, freq))
    feature.append(freq_business_feature(text, freq))
    feature.append(freq_message_feature(text, freq))
    feature.append(freq_volumes_feature(text, freq))
    feature.append(freq_revision_feature(text, freq))
    feature.append(freq_path_feature(text, freq))
    feature.append(freq_meter_feature(text, freq))
    feature.append(freq_memo_feature(text, freq))
    feature.append(freq_planning_feature(text, freq))
    feature.append(freq_pleased_feature(text, freq))
    feature.append(freq_record_feature(text, freq))
    feature.append(freq_out_feature(text, freq))
    feature.append(freq_semicolon_feature(text, freq))
    feature.append(freq_dollar_feature(text, freq))
    feature.append(freq_sharp_feature(text, freq))
    feature.append(freq_exclamation_feature(text, freq))
    feature.append(freq_para_feature(text, freq))
    feature.append(freq_bracket_feature(text, freq))
    feature.append(freq_and_feature(text, freq))


    # --------- Add your own features here ---------
    # Make sure type is int or float
    feature.append(http_feature(text,freq))
    feature.append(www_feature(text,freq))
    feature.append(link_feature(text,freq))
    feature.append(discount_feature(text,freq))
    feature.append(cost_feature(text,freq))
    feature.append(specials_feature(text,freq))
    feature.append(earn_feature(text,freq))
    feature.append(free_feature(text,freq))
    feature.append(luxury_feature(text,freq))
    feature.append(guaranteed_feature(text,freq))
    feature.append(website_feature(text,freq))
    feature.append(edu_feature(text,freq))
    feature.append(investment_feature(text,freq))
    feature.append(snoring_feature(text,freq))
    feature.append(loss_feature(text,freq))
    feature.append(investment_feature(text,freq))
    feature.append(valium_feature(text,freq))
    feature.append(viagra_feature(text,freq))
    feature.append(vicodin_feature(text,freq))
    feature.append(dear_feature(text,freq))
    feature.append(price_feature(text,freq))
    feature.append(url_feature(text,freq))
    feature.append(re_feature(text,freq))
    feature.append(meeting_feature(text,freq))
    #feature.append(regards_feature(text,freq))
    feature.append(dollar_feature(text,freq))
    #feature.append(best_feature(text,freq))
    feature.append(hello_feature(text,freq))
    feature.append(deal_feature(text,freq))
    feature.append(sales_feature(text,freq))
    feature.append(cash_feature(text,freq))
    feature.append(bonus_feature(text,freq))
    feature.append(cheap_feature(text,freq))
    feature.append(rate_feature(text,freq))
    feature.append(click_feature(text,freq))
    feature.append(insurance_feature(text,freq))  
    feature.append(preview_feature(text,freq))
    feature.append(order_feature(text,freq))
    feature.append(membership_feature(text,freq))
    feature.append(resume_feature(text,freq))
    feature.append(conference_feature(text,freq))
    feature.append(thanks_feature(text,freq))
    feature.append(investment_feature(text,freq))
    feature.append(dolsign_feature(text,freq))
    feature.append(fyi_feature(text,freq))
    feature.append(cc_feature(text,freq))
    return feature

# This method generates a design matrix with a list of filenames
# Each file is a single training example
def generate_design_matrix(filenames):
    design_matrix = []
    for filename in filenames:
        with open(filename) as f:
            text = f.read() # Read in text from file
            text = text.replace('\r\n', ' ') # Remove newline character
            words = re.findall(r'\w+', text)
            word_freq = defaultdict(int) # Frequency of all words
            for word in words:
                word_freq[word] += 1

            # Create a feature vector
            feature_vector = generate_feature_vector(text, word_freq)
            design_matrix.append(feature_vector)
    return design_matrix

# ************** Script starts here **************
# DO NOT MODIFY ANYTHING BELOW

spam_filenames = glob.glob(BASE_DIR + SPAM_DIR + '*.txt')
spam_design_matrix = generate_design_matrix(spam_filenames)
ham_filenames = glob.glob(BASE_DIR + HAM_DIR + '*.txt')
ham_design_matrix = generate_design_matrix(ham_filenames)
# Important: the test_filenames must be in numerical order as that is the
# order we will be evaluating your classifier
test_filenames = [BASE_DIR + TEST_DIR + str(x) + '.txt' for x in range(NUM_TEST_EXAMPLES)]
test_design_matrix = generate_design_matrix(test_filenames)

X = spam_design_matrix + ham_design_matrix
Y = [1]*len(spam_design_matrix) + [0]*len(ham_design_matrix)

file_dict = {}
file_dict['training_data'] = X
file_dict['training_labels'] = Y
file_dict['test_data'] = test_design_matrix
scipy.io.savemat('spam_data.mat', file_dict)

