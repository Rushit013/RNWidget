import React, {useState} from 'react';
import {View, TextInput, StyleSheet, NativeModules} from 'react-native';
import SharedGroupPreferences from 'react-native-shared-group-preferences';

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
  };

  return (
    <View style={styles.container}>
      <TextInput
        style={styles.input}
        onChangeText={newText => setText(newText)}
        value={text}
        returnKeyType="send"
        onEndEditing={handleSubmit}
        placeholder="Enter the text to display..."
      />
    </View>
  );
};

export default App;

const styles = StyleSheet.create({
  container: {
    marginTop: '50%',
    paddingHorizontal: 24,
  },
  input: {
    width: '100%',
    borderBottomWidth: 1,
    fontSize: 20,
    minHeight: 40,
  },
});
