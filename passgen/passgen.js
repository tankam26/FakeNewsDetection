const resultEL = document.getElementById("result");
const lengthEL = document.getElementById("length");
const numberEL = document.getElementById("number");
const uppercaseEL = document.getElementById("uppercase");
const lowercaseEL = document.getElementById("lowercase");
const symbolEL = document.getElementById("symbol");
const generateEL = document.getElementById("generate");
const clipboardEL = document.getElementById("clipboard");
const strengthEL = document.getElementById("strength");
const randomFunc = {
  lower: getRandomLowercase,
  upper: getRandomUppercase,
  number: getRandomNumber,
  symbol: getRandomSymbol
};
generateEL.addEventListener("click", () => {
  const length = +lengthEL.value;
  const hasLower = lowercaseEL.checked;
  const hasUpper = uppercaseEL.checked;
  const hasNumber = numberEL.checked;
  const hasSymbol = symbolEL.checked;

  const password = generatePassword(hasLower, hasUpper, hasNumber, hasSymbol, length);
  resultEL.innerText = password;
  strengthEL.innerText = getStrength(password, hasLower, hasUpper, hasNumber, hasSymbol);
});
clipboardEL.addEventListener("click", () => {
  const password = resultEL.innerText;
  if (!password) return;

  navigator.clipboard.writeText(password)
    .then(() => alert("Password copied to clipboard!"))
    .catch(err => alert("Failed to copy: " + err));
});
function generatePassword(lower, upper, number, symbol, length) {
  let generatedPassword = "";
  const typesCount = lower + upper + number + symbol;
  const typesArr = [{ lower }, { upper }, { number }, { symbol }].filter(type => Object.values(type)[0]);
  if (typesCount === 0) return "";
  for (let i = 0; i < length; i += typesCount) {
    typesArr.forEach(type => {
      const funcName = Object.keys(type)[0];
      generatedPassword += randomFunc[funcName]();
    });
  }

  return generatedPassword.slice(0, length);
}
function getRandomLowercase() {
  return String.fromCharCode(Math.floor(Math.random() * 26) + 97);
}
function getRandomUppercase() {
  return String.fromCharCode(Math.floor(Math.random() * 26) + 65);
}
function getRandomNumber() {
  return String.fromCharCode(Math.floor(Math.random() * 10) + 48);
}
function getRandomSymbol() {
  const symbols = "!@#$%^&*()_+|}{:><?/.,'][\\-=`";
  return symbols[Math.floor(Math.random() * symbols.length)];
}
function getStrength(password, lower, upper, number, symbol) {
  const typesUsed = [lower, upper, number, symbol].filter(Boolean).length;

  if (password.length === 0) return "";

  if (password.length >= 10 && typesUsed === 4) return "Strength:Strong";
  if (password.length >= 8 && typesUsed >= 2) return "Strength:Medium";
   return "Strength:Weak";
}
