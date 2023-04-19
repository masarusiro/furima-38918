const pay = () => {
  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY); //pay.jpのテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
     payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        // トークンは非表示
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      //フォームに存在するクレジット情報の削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      // フォームの情報を送信
      document.getElementById("charge-form").submit();
    });
  });
};
// payを読み込んだら実行
window.addEventListener("load", pay);