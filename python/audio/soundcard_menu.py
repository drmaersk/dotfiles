#! /usr/bin/env python3
from subprocess import run, PIPE
import os
from soundcard import sound_card_ops

#Todo: parse these?

class rofi():
    def __init__(self, options_list=list(), title = "No title"):
        self.title = title
        self.options_list = options_list

    def show(self):
        my_env = os.environ.copy()
        my_env["XENVIRONMENT"]="/home/robban/dev/res/rofi.config"

        input_string = ""
        for item in self.options_list:
            input_string += item + "\n"

        value = run(['rofi','-dmenu','-p',self.title, '-hide-scrollbar'],stdout=PIPE, input=input_string, encoding='utf-8', env=my_env).stdout
        return value.rstrip("\n\r");

    def set_title(self, new_title):
        self.title = new_title

    def set_list(self, new_options_list):
        self.options_list = new_options_list

def main():
    R = rofi()
    R.set_title("Sound card profile")
    s = sound_card_ops()
    operations = {"hdmi" : lambda : s.set_hdmi(),
                  "analog" : lambda : s.set_analog(),
                  "bluetoth" : lambda : s.set_bluetooth()}
    
    R.set_list(list(operations.keys()))
    operation = R.show()
    if operation:
        operations[operation]()


if __name__ == "__main__":
     main()



#s = sound_card_ops()

            
#s.set_card_profile("0", hdmi_profile)



# output = run(['pactl', 'list', 'short', 'cards'],stdout=PIPE,encoding='utf-8').stdout.rstrip('\n').split('\n')
#output = run(['pactl', 'list', 'short', 'sinks'],stdout=PIPE,encoding='utf-8').stdout.rstrip('\n').split('\n')
# cards_list = list()
#for card in output:
#    print(card.split())

# sound_cards_list = list()
    
# for card in cards_list:
#     sound_cards_list.append(sound_card(card[0],card[1],card[2]))

# for card in sound_cards_list:
#     if "alsa" in card.name:
#         print(card.index)

