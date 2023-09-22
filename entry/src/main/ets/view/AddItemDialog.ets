import { CommonConstants } from '../common/constant/CommonConstant'

@CustomDialog
export default struct AddTargetDialog {
  @State item: string = ''
  private controller?: CustomDialogController
  onClickOk?: (value: string) => void

  build() {
    Column() {
      Text('添加待办')
        .width(CommonConstants.FULL_WIDTH)
        .fontSize('20fp')
        .fontWeight(CommonConstants.FONT_WEIGHT)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
      TextInput({ placeholder: '请输入待办事项'})
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: '16fp'})
        .caretColor(Color.Blue)
        .backgroundColor("#0D182431")
        .width(CommonConstants.FULL_WIDTH)
        .height(CommonConstants.DIALOG_INPUT_HEIGHT)
        .margin({ top: CommonConstants.DIALOG_INPUT_MARGIN })
        .fontSize('16fp')
        .fontColor('#182431')
        .onChange((value: string) => {
          this.item = value
        })
      Blank()
      Row() {
        Button('取消')
          .dialogButtonStyle()
          .onClick(() => {
            this.controller?.close();
          })
        Divider()
          .vertical(true)
        Button('确定')
          .dialogButtonStyle()
          .onClick(() => {
            if (this.onClickOk !== undefined) {
              this.onClickOk(this.item)
            }
          })
      }
      .width(CommonConstants.DIALOG_OPERATION_WIDTH)
      .height(CommonConstants.DIALOG_OPERATION_HEIGHT)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding('24vp')
    .height('168vp')
    .width(CommonConstants.DIALOG_WIDTH)
    .borderRadius(CommonConstants.DIALOG_BORDER_RADIUS)
    .backgroundColor(Color.White)
  }
}

@Extend(Button) function dialogButtonStyle() {
  .fontSize('16fp')
  .height('32vp')
  .width('96vp')
  .backgroundColor(Color.White)
  .fontColor('#007DFF')
}