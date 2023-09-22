export default class ItemGroupBean {

  title: string
  isDone: boolean
  items: string[]

  constructor(title: string,isDone: boolean,items: string[]) {
    this.title = title
    this.isDone = isDone
    this.items = items
  }
}