window.addEventListener('load', () => {
  //item-priceを取得しpriceInputに格納
  const priceInput = document.getElementById("item-price");
  //priceInputが入力される度に発火
  priceInput.addEventListener("keyup", () => {
  // InputValueに入力された数字を格納
  const inputValue = priceInput.value;
  const addTaxDom = document.getElementById("add-tax-price");
  const ProfitDom = document.getElementById("profit");
  // 販売手数料を計算する処理を表示させるid=add-tax-priceに
  addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
  // 出品価格から販売手数料を引く処理をid=profitに
  ProfitDom.innerHTML = inputValue - addTaxDom.innerHTML;
  })
});