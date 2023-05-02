import React, {useState} from 'react';
import {
  View,
  TextInput,
  StyleSheet,
  NativeModules,
  SafeAreaView,
  Text,
  Image,
  ScrollView,
  KeyboardAvoidingView,
  Platform,
  ToastAndroid,
} from 'react-native';
import SharedGroupPreferences from 'react-native-shared-group-preferences';
import AwesomeButton from 'react-native-really-awesome-button';
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';

const group = 'group.streak';

const SharedStorage = NativeModules.SharedStorage;

const App = () => {
  const [text, setText] = useState('');
  const widgetData = {
    text,
  };

  const handleSubmit = async () => {
    try {
      // iOS
      await SharedGroupPreferences.setItem('widgetKey', widgetData, group);
    } catch (error) {
      console.log({error});
    }
    const value = `${text} days`;
    // Android
    SharedStorage.set(JSON.stringify({text: value}));
    ToastAndroid.show('Change value successfully!', ToastAndroid.SHORT);
  };

  return (
    <SafeAreaView style={styles.safeAreaContainer}>
      <KeyboardAwareScrollView
        enableOnAndroid
        extraScrollHeight={100}
        keyboardShouldPersistTaps="handled">
        <View style={styles.container}>
          <Text style={styles.heading}>Change Widget Value</Text>
          <View style={styles.bodyContainer}>
            <View style={styles.instructionContainer}>
              <View style={styles.thoughtContainer}>
                <Text style={styles.thoughtTitle}>
                  Enter the value that you want to display on your home widget
                </Text>
              </View>
              <View style={styles.thoughtPointer}></View>
              <Image
                source={require('./assets/bea.png')}
                style={styles.avatarImg}
              />
            </View>

            <TextInput
              style={styles.input}
              onChangeText={newText => setText(newText)}
              value={text}
              keyboardType="decimal-pad"
              placeholder="Enter the text to display..."
            />

            <AwesomeButton
              backgroundColor={'#33b8f6'}
              height={50}
              width={'100%'}
              backgroundDarker={'#eeefef'}
              backgroundShadow={'#f1f1f0'}
              style={styles.actionButton}
              onPress={handleSubmit}>
              Submit
            </AwesomeButton>
          </View>
        </View>
      </KeyboardAwareScrollView>
    </SafeAreaView>
  );
};

export default App;

const styles = StyleSheet.create({
  safeAreaContainer: {
    flex: 1,
    width: '100%',
    backgroundColor: '#fafaf3',
  },
  container: {
    flex: 1,
    width: '100%',
    padding: 12,
  },
  heading: {
    fontSize: 24,
    color: '#979995',
    textAlign: 'center',
  },
  input: {
    width: '100%',
    // fontSize: 20,
    minHeight: 50,
    borderWidth: 1,
    borderColor: '#c6c6c6',
    borderRadius: 8,
    padding: 12,
  },
  bodyContainer: {
    flex: 1,
    margin: 18,
  },
  instructionContainer: {
    margin: 25,
    paddingHorizontal: 20,
    paddingTop: 30,
    borderWidth: 1,
    borderRadius: 12,
    backgroundColor: '#ecedeb',
    borderColor: '#bebfbd',
    marginBottom: 35,
  },
  avatarImg: {
    height: 180,
    width: 180,
    resizeMode: 'contain',
    alignSelf: 'flex-end',
  },
  thoughtContainer: {
    minHeight: 50,
    borderRadius: 12,
    borderWidth: 1,
    padding: 12,
    backgroundColor: '#ffffff',
    borderColor: '#c6c6c6',
  },
  thoughtPointer: {
    width: 0,
    height: 0,
    borderStyle: 'solid',
    overflow: 'hidden',
    borderTopWidth: 12,
    borderRightWidth: 10,
    borderBottomWidth: 0,
    borderLeftWidth: 10,
    borderTopColor: 'blue',
    borderRightColor: 'transparent',
    borderBottomColor: 'transparent',
    borderLeftColor: 'transparent',
    marginTop: -1,
    marginLeft: '50%',
  },
  thoughtTitle: {
    fontSize: 14,
  },
  actionButton: {
    marginTop: 40,
  },
});
