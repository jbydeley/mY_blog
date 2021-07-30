const Hooks = {}
Hooks.MoveRoomba = {
    mounted() {
        this.oldX = 0
        this.oldY = 0
        this.handleEvent('move', ({x, y, dir}) => {
            console.log({x, y, dir})
            this.reset()

            this.oldX = x
            this.oldY = y
            const el = document.getElementById(`cell-${x}-${y}`)
            el.textContent = this.draw(dir)
        })
    },
    reset() {
        document.getElementById(`cell-${this.oldX}-${this.oldY}`).textContent = ''
    },
    draw(dir) {
        switch (dir) {
            case "north":
                return "^"

            case "east":
                return ">"
            
            case "south":
                return "\\/"
    
            case "west":
                return "<"
    
            default:
                return ""
        }
    }
}

export default Hooks