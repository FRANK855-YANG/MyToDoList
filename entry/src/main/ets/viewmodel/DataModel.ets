import ItemGroupBean from '../common/bean/ItemGroupBean'
// b最终修改
export class DataModel {
  itemsGroup: Array<ItemGroupBean> = [
    {
      title: '未完成',
      isDone: false,
      items: [
        'TS',
        'ArkTs',
        'ArkUI',
        'EcoDev4.0',
        '自定义弹窗']
    },
    {
      title: '已完成',
      isDone: true,
      items: [
        '基本语法',
        '状态管理',
        '渲染控制',
        '开发布局',
        '添加组件',
        '待办事项开发',
        '展示列表开发',
        '生命周期理解'
      ]
    }
  ]

  getData(): Array<ItemGroupBean> {
    return this.itemsGroup
  }

  addData(item: string) {
    this.itemsGroup[0].items.unshift(item)
  }
}

export default new DataModel()


