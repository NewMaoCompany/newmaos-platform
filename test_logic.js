const topicParamRaw = 'Limits';
const COURSE_CONTENT_DATA = {
    'Both_Limits': {},
    'Both_Derivatives': {}
};

const keys = Object.keys(COURSE_CONTENT_DATA);
const topicParam = keys.find(k => k.toLowerCase() === topicParamRaw.toLowerCase()) || topicParamRaw;

console.log("topicParamRaw:", topicParamRaw);
console.log("topicParam:", topicParam);
