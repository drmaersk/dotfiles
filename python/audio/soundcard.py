from subprocess import run, PIPE

class sound_card():
    def __init__(self, index, name, driver):
        self.index = index
        self.name = name
        self.driver = driver
        self.sinkid = ""
    def toString(self):
        return "" + self.index + " " + self.name + " " + self.driver + " " + self.sinkid

#move sinkid to moduleid        
class sink_input:
    def __init__(self, sinkid, moduleid):
        self.owner_sinkid = sinkid
        self.owner_moduleid = moduleid

hdmi_profile = "output:hdmi-stereo"
analog_profile = "output:analog-stereo"

class sound_card_ops():
    def __init__(self):
        self.card_list = list()
        self.sink_inputs = list()
        self.update_card_list()
        self.update_sinks()
        self.update_sink_inputs()

    def __pactl_helper__(self, cmd):
        output = run(['pactl', 'list', 'short', cmd],stdout=PIPE,encoding='utf-8').stdout.rstrip('\n').split('\n')
        r_list = list()
        for row in output:
            r_list.append(row.split())
        return r_list
        
    def update_card_list(self):
        scard_list = self.__pactl_helper__('cards')
        for scard in scard_list:
            self.card_list.append(sound_card(scard[0],scard[1],scard[2]))

    def update_sinks(self):
        sinks_list = self.__pactl_helper__('sinks')
        for sink in sinks_list:
            for s_card in self.card_list:
                if s_card.driver == sink[2]:
                    s_card.sinkid = sink[0]

    def update_sink_inputs(self):
        sink_input_list = self.__pactl_helper__('sink-inputs')
        for sink_elem in sink_input_list:
            if sink_elem:
                self.sink_inputs.append(sink_input(sink_elem[1],sink_elem[0]))

    def set_card_profile(self, card_index, profile_name):
        run(['pactl', 'set-card-profile', card_index, profile_name],stdout=PIPE,encoding='utf-8')

    def get_scard_by(self, attrmap) -> sound_card:
        for name in attrmap.keys():
            for card in self.card_list:
                attr = getattr(card, name)
                if attrmap[name] in attr:
                    return card

    def move_inputs_to_sink_id(self, sink_id):
        for sink_input in self.sink_inputs:
            if sink_input.owner_sinkid != sink_id:
                run(['pactl', 'move-sink-input', sink_input.owner_moduleid, sink_id],stdout=PIPE,encoding='utf-8')

    def set_hdmi(self): 
        scard = self.get_scard_by({"name":"alsa"})
        self.set_card_profile(scard.index, hdmi_profile)
        self.move_inputs_to_sink_id(scard.sinkid)
        
    def set_analog(self):
        scard = self.get_scard_by({"name":"alsa"})
        self.set_card_profile(scard.index, analog_profile)
        self.move_inputs_to_sink_id(scard.sinkid)

    def set_bluetooth(self):
        scard = self.get_scard_by({"name":"blue"})
        self.set_card_profile(scard.index, "a2dp_sink")
        self.move_inputs_to_sink_id(scard.sinkid)

