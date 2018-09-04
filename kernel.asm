
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 80 2e 10 80       	mov    $0x80102e80,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 00 72 10 80       	push   $0x80107200
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 75 43 00 00       	call   801043d0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 72 10 80       	push   $0x80107207
80100097:	50                   	push   %eax
80100098:	e8 23 42 00 00       	call   801042c0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 e7 43 00 00       	call   801044d0 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 89 44 00 00       	call   801045f0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 41 00 00       	call   80104300 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 5d 1f 00 00       	call   801020e0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 0e 72 10 80       	push   $0x8010720e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 ed 41 00 00       	call   801043a0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 17 1f 00 00       	jmp    801020e0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 1f 72 10 80       	push   $0x8010721f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 ac 41 00 00       	call   801043a0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 5c 41 00 00       	call   80104360 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 c0 42 00 00       	call   801044d0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 8f 43 00 00       	jmp    801045f0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 72 10 80       	push   $0x80107226
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 cb 14 00 00       	call   80101750 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 3f 42 00 00       	call   801044d0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002a6:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 a0 ff 10 80       	push   $0x8010ffa0
801002bd:	e8 be 3b 00 00       	call   80103e80 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 f9 35 00 00       	call   801038d0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 a5 10 80       	push   $0x8010a520
801002e6:	e8 05 43 00 00       	call   801045f0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 7d 13 00 00       	call   80101670 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 ff 10 80 	movsbl -0x7fef00e0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 a5 42 00 00       	call   801045f0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 1d 13 00 00       	call   80101670 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 72 23 00 00       	call   80102700 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 2d 72 10 80       	push   $0x8010722d
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 ea 77 10 80 	movl   $0x801077ea,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 33 40 00 00       	call   801043f0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 41 72 10 80       	push   $0x80107241
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 c1 59 00 00       	call   80105de0 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100434:	89 ca                	mov    %ecx,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c6                	mov    %eax,%esi
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 ca                	mov    %ecx,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 f0                	or     %esi,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 9c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ebx
80100492:	89 f9                	mov    %edi,%ecx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 c8                	mov    %ecx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 03             	mov    %ax,(%ebx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 08 59 00 00       	call   80105de0 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 fc 58 00 00       	call   80105de0 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 f0 58 00 00       	call   80105de0 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	83 ef 50             	sub    $0x50,%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004fe:	be 07 00 00 00       	mov    $0x7,%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100503:	68 60 0e 00 00       	push   $0xe60
80100508:	68 a0 80 0b 80       	push   $0x800b80a0
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d 9c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	68 00 80 0b 80       	push   $0x800b8000
80100519:	e8 d2 41 00 00       	call   801046f0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010051e:	b8 80 07 00 00       	mov    $0x780,%eax
80100523:	83 c4 0c             	add    $0xc,%esp
80100526:	29 f8                	sub    %edi,%eax
80100528:	01 c0                	add    %eax,%eax
8010052a:	50                   	push   %eax
8010052b:	6a 00                	push   $0x0
8010052d:	53                   	push   %ebx
8010052e:	e8 0d 41 00 00       	call   80104640 <memset>
80100533:	89 f9                	mov    %edi,%ecx
80100535:	83 c4 10             	add    $0x10,%esp
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 45 72 10 80       	push   $0x80107245
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	bb 00 80 0b 80       	mov    $0x800b8000,%ebx
8010055a:	31 c9                	xor    %ecx,%ecx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
8010058d:	74 04                	je     80100593 <printint+0x13>
8010058f:	85 c0                	test   %eax,%eax
80100591:	78 57                	js     801005ea <printint+0x6a>
    x = -xx;
  else
    x = xx;
80100593:	31 ff                	xor    %edi,%edi

  i = 0;
80100595:	31 c9                	xor    %ecx,%ecx
80100597:	eb 09                	jmp    801005a2 <printint+0x22>
80100599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
801005a0:	89 d9                	mov    %ebx,%ecx
801005a2:	31 d2                	xor    %edx,%edx
801005a4:	8d 59 01             	lea    0x1(%ecx),%ebx
801005a7:	f7 f6                	div    %esi
801005a9:	0f b6 92 70 72 10 80 	movzbl -0x7fef8d90(%edx),%edx
  }while((x /= base) != 0);
801005b0:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005b2:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005b6:	75 e8                	jne    801005a0 <printint+0x20>

  if(sign)
801005b8:	85 ff                	test   %edi,%edi
801005ba:	74 08                	je     801005c4 <printint+0x44>
    buf[i++] = '-';
801005bc:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
801005c1:	8d 59 02             	lea    0x2(%ecx),%ebx

  while(--i >= 0)
801005c4:	83 eb 01             	sub    $0x1,%ebx
801005c7:	89 f6                	mov    %esi,%esi
801005c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    consputc(buf[i]);
801005d0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005d5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801005d8:	e8 13 fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005dd:	83 fb ff             	cmp    $0xffffffff,%ebx
801005e0:	75 ee                	jne    801005d0 <printint+0x50>
    consputc(buf[i]);
}
801005e2:	83 c4 1c             	add    $0x1c,%esp
801005e5:	5b                   	pop    %ebx
801005e6:	5e                   	pop    %esi
801005e7:	5f                   	pop    %edi
801005e8:	5d                   	pop    %ebp
801005e9:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ea:	f7 d8                	neg    %eax
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005ec:	bf 01 00 00 00       	mov    $0x1,%edi
    x = -xx;
801005f1:	eb a2                	jmp    80100595 <printint+0x15>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 3c 11 00 00       	call   80101750 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 b0 3e 00 00       	call   801044d0 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 a4 3f 00 00       	call   801045f0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 1b 10 00 00       	call   80101670 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 27 01 00 00    	jne    801007a0 <cprintf+0x140>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 75 08             	mov    0x8(%ebp),%esi
8010067c:	85 f6                	test   %esi,%esi
8010067e:	0f 84 40 01 00 00    	je     801007c4 <cprintf+0x164>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100684:	0f b6 06             	movzbl (%esi),%eax
80100687:	31 db                	xor    %ebx,%ebx
80100689:	8d 7d 0c             	lea    0xc(%ebp),%edi
8010068c:	85 c0                	test   %eax,%eax
8010068e:	75 51                	jne    801006e1 <cprintf+0x81>
80100690:	eb 64                	jmp    801006f6 <cprintf+0x96>
80100692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100698:	83 c3 01             	add    $0x1,%ebx
8010069b:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
8010069f:	85 d2                	test   %edx,%edx
801006a1:	74 53                	je     801006f6 <cprintf+0x96>
      break;
    switch(c){
801006a3:	83 fa 70             	cmp    $0x70,%edx
801006a6:	74 7a                	je     80100722 <cprintf+0xc2>
801006a8:	7f 6e                	jg     80100718 <cprintf+0xb8>
801006aa:	83 fa 25             	cmp    $0x25,%edx
801006ad:	0f 84 ad 00 00 00    	je     80100760 <cprintf+0x100>
801006b3:	83 fa 64             	cmp    $0x64,%edx
801006b6:	0f 85 84 00 00 00    	jne    80100740 <cprintf+0xe0>
    case 'd':
      printint(*argp++, 10, 1);
801006bc:	8d 47 04             	lea    0x4(%edi),%eax
801006bf:	b9 01 00 00 00       	mov    $0x1,%ecx
801006c4:	ba 0a 00 00 00       	mov    $0xa,%edx
801006c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006cc:	8b 07                	mov    (%edi),%eax
801006ce:	e8 ad fe ff ff       	call   80100580 <printint>
801006d3:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d6:	83 c3 01             	add    $0x1,%ebx
801006d9:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006dd:	85 c0                	test   %eax,%eax
801006df:	74 15                	je     801006f6 <cprintf+0x96>
    if(c != '%'){
801006e1:	83 f8 25             	cmp    $0x25,%eax
801006e4:	74 b2                	je     80100698 <cprintf+0x38>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006e6:	e8 05 fd ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006eb:	83 c3 01             	add    $0x1,%ebx
801006ee:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006f2:	85 c0                	test   %eax,%eax
801006f4:	75 eb                	jne    801006e1 <cprintf+0x81>
      consputc(c);
      break;
    }
  }

  if(locking)
801006f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006f9:	85 c0                	test   %eax,%eax
801006fb:	74 10                	je     8010070d <cprintf+0xad>
    release(&cons.lock);
801006fd:	83 ec 0c             	sub    $0xc,%esp
80100700:	68 20 a5 10 80       	push   $0x8010a520
80100705:	e8 e6 3e 00 00       	call   801045f0 <release>
8010070a:	83 c4 10             	add    $0x10,%esp
}
8010070d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100710:	5b                   	pop    %ebx
80100711:	5e                   	pop    %esi
80100712:	5f                   	pop    %edi
80100713:	5d                   	pop    %ebp
80100714:	c3                   	ret    
80100715:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100718:	83 fa 73             	cmp    $0x73,%edx
8010071b:	74 53                	je     80100770 <cprintf+0x110>
8010071d:	83 fa 78             	cmp    $0x78,%edx
80100720:	75 1e                	jne    80100740 <cprintf+0xe0>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100722:	8d 47 04             	lea    0x4(%edi),%eax
80100725:	31 c9                	xor    %ecx,%ecx
80100727:	ba 10 00 00 00       	mov    $0x10,%edx
8010072c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010072f:	8b 07                	mov    (%edi),%eax
80100731:	e8 4a fe ff ff       	call   80100580 <printint>
80100736:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      break;
80100739:	eb 9b                	jmp    801006d6 <cprintf+0x76>
8010073b:	90                   	nop
8010073c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100740:	b8 25 00 00 00       	mov    $0x25,%eax
80100745:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100748:	e8 a3 fc ff ff       	call   801003f0 <consputc>
      consputc(c);
8010074d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100750:	89 d0                	mov    %edx,%eax
80100752:	e8 99 fc ff ff       	call   801003f0 <consputc>
      break;
80100757:	e9 7a ff ff ff       	jmp    801006d6 <cprintf+0x76>
8010075c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100760:	b8 25 00 00 00       	mov    $0x25,%eax
80100765:	e8 86 fc ff ff       	call   801003f0 <consputc>
8010076a:	e9 7c ff ff ff       	jmp    801006eb <cprintf+0x8b>
8010076f:	90                   	nop
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100770:	8d 47 04             	lea    0x4(%edi),%eax
80100773:	8b 3f                	mov    (%edi),%edi
80100775:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100778:	85 ff                	test   %edi,%edi
8010077a:	75 0c                	jne    80100788 <cprintf+0x128>
8010077c:	eb 3a                	jmp    801007b8 <cprintf+0x158>
8010077e:	66 90                	xchg   %ax,%ax
        s = "(null)";
      for(; *s; s++)
80100780:	83 c7 01             	add    $0x1,%edi
        consputc(*s);
80100783:	e8 68 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100788:	0f be 07             	movsbl (%edi),%eax
8010078b:	84 c0                	test   %al,%al
8010078d:	75 f1                	jne    80100780 <cprintf+0x120>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010078f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80100792:	e9 3f ff ff ff       	jmp    801006d6 <cprintf+0x76>
80100797:	89 f6                	mov    %esi,%esi
80100799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007a0:	83 ec 0c             	sub    $0xc,%esp
801007a3:	68 20 a5 10 80       	push   $0x8010a520
801007a8:	e8 23 3d 00 00       	call   801044d0 <acquire>
801007ad:	83 c4 10             	add    $0x10,%esp
801007b0:	e9 c4 fe ff ff       	jmp    80100679 <cprintf+0x19>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007b8:	b8 28 00 00 00       	mov    $0x28,%eax
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
801007bd:	bf 58 72 10 80       	mov    $0x80107258,%edi
801007c2:	eb bc                	jmp    80100780 <cprintf+0x120>
  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");
801007c4:	83 ec 0c             	sub    $0xc,%esp
801007c7:	68 5f 72 10 80       	push   $0x8010725f
801007cc:	e8 9f fb ff ff       	call   80100370 <panic>
801007d1:	eb 0d                	jmp    801007e0 <consoleintr>
801007d3:	90                   	nop
801007d4:	90                   	nop
801007d5:	90                   	nop
801007d6:	90                   	nop
801007d7:	90                   	nop
801007d8:	90                   	nop
801007d9:	90                   	nop
801007da:	90                   	nop
801007db:	90                   	nop
801007dc:	90                   	nop
801007dd:	90                   	nop
801007de:	90                   	nop
801007df:	90                   	nop

801007e0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007e0:	55                   	push   %ebp
801007e1:	89 e5                	mov    %esp,%ebp
801007e3:	57                   	push   %edi
801007e4:	56                   	push   %esi
801007e5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007e6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007e8:	83 ec 18             	sub    $0x18,%esp
801007eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007ee:	68 20 a5 10 80       	push   $0x8010a520
801007f3:	e8 d8 3c 00 00       	call   801044d0 <acquire>
  while((c = getc()) >= 0){
801007f8:	83 c4 10             	add    $0x10,%esp
801007fb:	90                   	nop
801007fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100800:	ff d3                	call   *%ebx
80100802:	85 c0                	test   %eax,%eax
80100804:	89 c7                	mov    %eax,%edi
80100806:	78 48                	js     80100850 <consoleintr+0x70>
    switch(c){
80100808:	83 ff 10             	cmp    $0x10,%edi
8010080b:	0f 84 3f 01 00 00    	je     80100950 <consoleintr+0x170>
80100811:	7e 5d                	jle    80100870 <consoleintr+0x90>
80100813:	83 ff 15             	cmp    $0x15,%edi
80100816:	0f 84 dc 00 00 00    	je     801008f8 <consoleintr+0x118>
8010081c:	83 ff 7f             	cmp    $0x7f,%edi
8010081f:	75 54                	jne    80100875 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100821:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100826:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010082c:	74 d2                	je     80100800 <consoleintr+0x20>
        input.e--;
8010082e:	83 e8 01             	sub    $0x1,%eax
80100831:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100836:	b8 00 01 00 00       	mov    $0x100,%eax
8010083b:	e8 b0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100840:	ff d3                	call   *%ebx
80100842:	85 c0                	test   %eax,%eax
80100844:	89 c7                	mov    %eax,%edi
80100846:	79 c0                	jns    80100808 <consoleintr+0x28>
80100848:	90                   	nop
80100849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100850:	83 ec 0c             	sub    $0xc,%esp
80100853:	68 20 a5 10 80       	push   $0x8010a520
80100858:	e8 93 3d 00 00       	call   801045f0 <release>
  if(doprocdump) {
8010085d:	83 c4 10             	add    $0x10,%esp
80100860:	85 f6                	test   %esi,%esi
80100862:	0f 85 f8 00 00 00    	jne    80100960 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100868:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010086b:	5b                   	pop    %ebx
8010086c:	5e                   	pop    %esi
8010086d:	5f                   	pop    %edi
8010086e:	5d                   	pop    %ebp
8010086f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100870:	83 ff 08             	cmp    $0x8,%edi
80100873:	74 ac                	je     80100821 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100875:	85 ff                	test   %edi,%edi
80100877:	74 87                	je     80100800 <consoleintr+0x20>
80100879:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010087e:	89 c2                	mov    %eax,%edx
80100880:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100886:	83 fa 7f             	cmp    $0x7f,%edx
80100889:	0f 87 71 ff ff ff    	ja     80100800 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010088f:	8d 50 01             	lea    0x1(%eax),%edx
80100892:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100895:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100898:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
8010089e:	0f 84 c8 00 00 00    	je     8010096c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008a4:	89 f9                	mov    %edi,%ecx
801008a6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008ac:	89 f8                	mov    %edi,%eax
801008ae:	e8 3d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008b3:	83 ff 0a             	cmp    $0xa,%edi
801008b6:	0f 84 c1 00 00 00    	je     8010097d <consoleintr+0x19d>
801008bc:	83 ff 04             	cmp    $0x4,%edi
801008bf:	0f 84 b8 00 00 00    	je     8010097d <consoleintr+0x19d>
801008c5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008ca:	83 e8 80             	sub    $0xffffff80,%eax
801008cd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
801008d3:	0f 85 27 ff ff ff    	jne    80100800 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008d9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008dc:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801008e1:	68 a0 ff 10 80       	push   $0x8010ffa0
801008e6:	e8 55 37 00 00       	call   80104040 <wakeup>
801008eb:	83 c4 10             	add    $0x10,%esp
801008ee:	e9 0d ff ff ff       	jmp    80100800 <consoleintr+0x20>
801008f3:	90                   	nop
801008f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008f8:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008fd:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100903:	75 2b                	jne    80100930 <consoleintr+0x150>
80100905:	e9 f6 fe ff ff       	jmp    80100800 <consoleintr+0x20>
8010090a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100910:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100915:	b8 00 01 00 00       	mov    $0x100,%eax
8010091a:	e8 d1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010091f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100924:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010092a:	0f 84 d0 fe ff ff    	je     80100800 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100930:	83 e8 01             	sub    $0x1,%eax
80100933:	89 c2                	mov    %eax,%edx
80100935:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100938:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010093f:	75 cf                	jne    80100910 <consoleintr+0x130>
80100941:	e9 ba fe ff ff       	jmp    80100800 <consoleintr+0x20>
80100946:	8d 76 00             	lea    0x0(%esi),%esi
80100949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100950:	be 01 00 00 00       	mov    $0x1,%esi
80100955:	e9 a6 fe ff ff       	jmp    80100800 <consoleintr+0x20>
8010095a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100960:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100963:	5b                   	pop    %ebx
80100964:	5e                   	pop    %esi
80100965:	5f                   	pop    %edi
80100966:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100967:	e9 c4 37 00 00       	jmp    80104130 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010096c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100973:	b8 0a 00 00 00       	mov    $0xa,%eax
80100978:	e8 73 fa ff ff       	call   801003f0 <consputc>
8010097d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100982:	e9 52 ff ff ff       	jmp    801008d9 <consoleintr+0xf9>
80100987:	89 f6                	mov    %esi,%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100990 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100990:	55                   	push   %ebp
80100991:	89 e5                	mov    %esp,%ebp
80100993:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100996:	68 68 72 10 80       	push   $0x80107268
8010099b:	68 20 a5 10 80       	push   $0x8010a520
801009a0:	e8 2b 3a 00 00       	call   801043d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
801009a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009ac:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009b3:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009b6:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009bd:	02 10 80 
  cons.locking = 1;
801009c0:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009c7:	00 00 00 

  picenable(IRQ_KBD);
801009ca:	e8 41 28 00 00       	call   80103210 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009cf:	58                   	pop    %eax
801009d0:	5a                   	pop    %edx
801009d1:	6a 00                	push   $0x0
801009d3:	6a 01                	push   $0x1
801009d5:	e8 c6 18 00 00       	call   801022a0 <ioapicenable>
}
801009da:	83 c4 10             	add    $0x10,%esp
801009dd:	c9                   	leave  
801009de:	c3                   	ret    
801009df:	90                   	nop

801009e0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009e0:	55                   	push   %ebp
801009e1:	89 e5                	mov    %esp,%ebp
801009e3:	57                   	push   %edi
801009e4:	56                   	push   %esi
801009e5:	53                   	push   %ebx
801009e6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009ec:	e8 df 2e 00 00       	call   801038d0 <myproc>
801009f1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009f7:	e8 74 21 00 00       	call   80102b70 <begin_op>

  if((ip = namei(path)) == 0){
801009fc:	83 ec 0c             	sub    $0xc,%esp
801009ff:	ff 75 08             	pushl  0x8(%ebp)
80100a02:	e8 99 14 00 00       	call   80101ea0 <namei>
80100a07:	83 c4 10             	add    $0x10,%esp
80100a0a:	85 c0                	test   %eax,%eax
80100a0c:	0f 84 9c 01 00 00    	je     80100bae <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a12:	83 ec 0c             	sub    $0xc,%esp
80100a15:	89 c3                	mov    %eax,%ebx
80100a17:	50                   	push   %eax
80100a18:	e8 53 0c 00 00       	call   80101670 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a1d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a23:	6a 34                	push   $0x34
80100a25:	6a 00                	push   $0x0
80100a27:	50                   	push   %eax
80100a28:	53                   	push   %ebx
80100a29:	e8 02 0f 00 00       	call   80101930 <readi>
80100a2e:	83 c4 20             	add    $0x20,%esp
80100a31:	83 f8 34             	cmp    $0x34,%eax
80100a34:	74 22                	je     80100a58 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a36:	83 ec 0c             	sub    $0xc,%esp
80100a39:	53                   	push   %ebx
80100a3a:	e8 a1 0e 00 00       	call   801018e0 <iunlockput>
    end_op();
80100a3f:	e8 9c 21 00 00       	call   80102be0 <end_op>
80100a44:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a4f:	5b                   	pop    %ebx
80100a50:	5e                   	pop    %esi
80100a51:	5f                   	pop    %edi
80100a52:	5d                   	pop    %ebp
80100a53:	c3                   	ret    
80100a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a58:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a5f:	45 4c 46 
80100a62:	75 d2                	jne    80100a36 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a64:	e8 f7 64 00 00       	call   80106f60 <setupkvm>
80100a69:	85 c0                	test   %eax,%eax
80100a6b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a71:	74 c3                	je     80100a36 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a73:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a7a:	00 
80100a7b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a81:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a88:	00 00 00 
80100a8b:	0f 84 c5 00 00 00    	je     80100b56 <exec+0x176>
80100a91:	31 ff                	xor    %edi,%edi
80100a93:	eb 18                	jmp    80100aad <exec+0xcd>
80100a95:	8d 76 00             	lea    0x0(%esi),%esi
80100a98:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a9f:	83 c7 01             	add    $0x1,%edi
80100aa2:	83 c6 20             	add    $0x20,%esi
80100aa5:	39 f8                	cmp    %edi,%eax
80100aa7:	0f 8e a9 00 00 00    	jle    80100b56 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100aad:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ab3:	6a 20                	push   $0x20
80100ab5:	56                   	push   %esi
80100ab6:	50                   	push   %eax
80100ab7:	53                   	push   %ebx
80100ab8:	e8 73 0e 00 00       	call   80101930 <readi>
80100abd:	83 c4 10             	add    $0x10,%esp
80100ac0:	83 f8 20             	cmp    $0x20,%eax
80100ac3:	75 7b                	jne    80100b40 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ac5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acc:	75 ca                	jne    80100a98 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100ace:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ada:	72 64                	jb     80100b40 <exec+0x160>
80100adc:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae2:	72 5c                	jb     80100b40 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ae4:	83 ec 04             	sub    $0x4,%esp
80100ae7:	50                   	push   %eax
80100ae8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100aee:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af4:	e8 c7 62 00 00       	call   80106dc0 <allocuvm>
80100af9:	83 c4 10             	add    $0x10,%esp
80100afc:	85 c0                	test   %eax,%eax
80100afe:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b04:	74 3a                	je     80100b40 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b06:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b11:	75 2d                	jne    80100b40 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b13:	83 ec 0c             	sub    $0xc,%esp
80100b16:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b22:	53                   	push   %ebx
80100b23:	50                   	push   %eax
80100b24:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b2a:	e8 d1 61 00 00       	call   80106d00 <loaduvm>
80100b2f:	83 c4 20             	add    $0x20,%esp
80100b32:	85 c0                	test   %eax,%eax
80100b34:	0f 89 5e ff ff ff    	jns    80100a98 <exec+0xb8>
80100b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b40:	83 ec 0c             	sub    $0xc,%esp
80100b43:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b49:	e8 92 63 00 00       	call   80106ee0 <freevm>
80100b4e:	83 c4 10             	add    $0x10,%esp
80100b51:	e9 e0 fe ff ff       	jmp    80100a36 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b56:	83 ec 0c             	sub    $0xc,%esp
80100b59:	53                   	push   %ebx
80100b5a:	e8 81 0d 00 00       	call   801018e0 <iunlockput>
  end_op();
80100b5f:	e8 7c 20 00 00       	call   80102be0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b64:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b6a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b6d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b77:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b7d:	52                   	push   %edx
80100b7e:	50                   	push   %eax
80100b7f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b85:	e8 36 62 00 00       	call   80106dc0 <allocuvm>
80100b8a:	83 c4 10             	add    $0x10,%esp
80100b8d:	85 c0                	test   %eax,%eax
80100b8f:	89 c6                	mov    %eax,%esi
80100b91:	75 3a                	jne    80100bcd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b93:	83 ec 0c             	sub    $0xc,%esp
80100b96:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b9c:	e8 3f 63 00 00       	call   80106ee0 <freevm>
80100ba1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100ba4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ba9:	e9 9e fe ff ff       	jmp    80100a4c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bae:	e8 2d 20 00 00       	call   80102be0 <end_op>
    cprintf("exec: fail\n");
80100bb3:	83 ec 0c             	sub    $0xc,%esp
80100bb6:	68 81 72 10 80       	push   $0x80107281
80100bbb:	e8 a0 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bc0:	83 c4 10             	add    $0x10,%esp
80100bc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc8:	e9 7f fe ff ff       	jmp    80100a4c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bcd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bd3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bd6:	31 ff                	xor    %edi,%edi
80100bd8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bda:	50                   	push   %eax
80100bdb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100be1:	e8 1a 64 00 00       	call   80107000 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100be9:	83 c4 10             	add    $0x10,%esp
80100bec:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bf2:	8b 00                	mov    (%eax),%eax
80100bf4:	85 c0                	test   %eax,%eax
80100bf6:	74 79                	je     80100c71 <exec+0x291>
80100bf8:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100bfe:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c04:	eb 13                	jmp    80100c19 <exec+0x239>
80100c06:	8d 76 00             	lea    0x0(%esi),%esi
80100c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c10:	83 ff 20             	cmp    $0x20,%edi
80100c13:	0f 84 7a ff ff ff    	je     80100b93 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c19:	83 ec 0c             	sub    $0xc,%esp
80100c1c:	50                   	push   %eax
80100c1d:	e8 3e 3c 00 00       	call   80104860 <strlen>
80100c22:	f7 d0                	not    %eax
80100c24:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c26:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c29:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c2a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c2d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c30:	e8 2b 3c 00 00       	call   80104860 <strlen>
80100c35:	83 c0 01             	add    $0x1,%eax
80100c38:	50                   	push   %eax
80100c39:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c3c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c3f:	53                   	push   %ebx
80100c40:	56                   	push   %esi
80100c41:	e8 0a 65 00 00       	call   80107150 <copyout>
80100c46:	83 c4 20             	add    $0x20,%esp
80100c49:	85 c0                	test   %eax,%eax
80100c4b:	0f 88 42 ff ff ff    	js     80100b93 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c51:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c54:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c5b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c5e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c64:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c67:	85 c0                	test   %eax,%eax
80100c69:	75 a5                	jne    80100c10 <exec+0x230>
80100c6b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c71:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c78:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c7a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c81:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c85:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c8c:	ff ff ff 
  ustack[1] = argc;
80100c8f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c95:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c97:	83 c0 0c             	add    $0xc,%eax
80100c9a:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9c:	50                   	push   %eax
80100c9d:	52                   	push   %edx
80100c9e:	53                   	push   %ebx
80100c9f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cab:	e8 a0 64 00 00       	call   80107150 <copyout>
80100cb0:	83 c4 10             	add    $0x10,%esp
80100cb3:	85 c0                	test   %eax,%eax
80100cb5:	0f 88 d8 fe ff ff    	js     80100b93 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cbb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cbe:	0f b6 10             	movzbl (%eax),%edx
80100cc1:	84 d2                	test   %dl,%dl
80100cc3:	74 19                	je     80100cde <exec+0x2fe>
80100cc5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cc8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100ccb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cce:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100cd1:	0f 44 c8             	cmove  %eax,%ecx
80100cd4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cd7:	84 d2                	test   %dl,%dl
80100cd9:	75 f0                	jne    80100ccb <exec+0x2eb>
80100cdb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cde:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100ce4:	50                   	push   %eax
80100ce5:	6a 10                	push   $0x10
80100ce7:	ff 75 08             	pushl  0x8(%ebp)
80100cea:	89 f8                	mov    %edi,%eax
80100cec:	83 c0 6c             	add    $0x6c,%eax
80100cef:	50                   	push   %eax
80100cf0:	e8 2b 3b 00 00       	call   80104820 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100cf5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100cfb:	89 f8                	mov    %edi,%eax
80100cfd:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d00:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d02:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d05:	89 c1                	mov    %eax,%ecx
80100d07:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d0d:	8b 40 18             	mov    0x18(%eax),%eax
80100d10:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d13:	8b 41 18             	mov    0x18(%ecx),%eax
80100d16:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d19:	89 0c 24             	mov    %ecx,(%esp)
80100d1c:	e8 4f 5e 00 00       	call   80106b70 <switchuvm>
  freevm(oldpgdir);
80100d21:	89 3c 24             	mov    %edi,(%esp)
80100d24:	e8 b7 61 00 00       	call   80106ee0 <freevm>
  return 0;
80100d29:	83 c4 10             	add    $0x10,%esp
80100d2c:	31 c0                	xor    %eax,%eax
80100d2e:	e9 19 fd ff ff       	jmp    80100a4c <exec+0x6c>
80100d33:	66 90                	xchg   %ax,%ax
80100d35:	66 90                	xchg   %ax,%ax
80100d37:	66 90                	xchg   %ax,%ax
80100d39:	66 90                	xchg   %ax,%ax
80100d3b:	66 90                	xchg   %ax,%ax
80100d3d:	66 90                	xchg   %ax,%ax
80100d3f:	90                   	nop

80100d40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d40:	55                   	push   %ebp
80100d41:	89 e5                	mov    %esp,%ebp
80100d43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d46:	68 8d 72 10 80       	push   $0x8010728d
80100d4b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d50:	e8 7b 36 00 00       	call   801043d0 <initlock>
}
80100d55:	83 c4 10             	add    $0x10,%esp
80100d58:	c9                   	leave  
80100d59:	c3                   	ret    
80100d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d64:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d69:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d6c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d71:	e8 5a 37 00 00       	call   801044d0 <acquire>
80100d76:	83 c4 10             	add    $0x10,%esp
80100d79:	eb 10                	jmp    80100d8b <filealloc+0x2b>
80100d7b:	90                   	nop
80100d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d80:	83 c3 18             	add    $0x18,%ebx
80100d83:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d89:	73 25                	jae    80100db0 <filealloc+0x50>
    if(f->ref == 0){
80100d8b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d8e:	85 c0                	test   %eax,%eax
80100d90:	75 ee                	jne    80100d80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100d92:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100d95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d9c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100da1:	e8 4a 38 00 00       	call   801045f0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100da6:	89 d8                	mov    %ebx,%eax
  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      release(&ftable.lock);
      return f;
80100da8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dae:	c9                   	leave  
80100daf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100db0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100db3:	31 db                	xor    %ebx,%ebx
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100db5:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dba:	e8 31 38 00 00       	call   801045f0 <release>
  return 0;
}
80100dbf:	89 d8                	mov    %ebx,%eax
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
80100dc1:	83 c4 10             	add    $0x10,%esp
}
80100dc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dc7:	c9                   	leave  
80100dc8:	c3                   	ret    
80100dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100dd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	53                   	push   %ebx
80100dd4:	83 ec 10             	sub    $0x10,%esp
80100dd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dda:	68 c0 ff 10 80       	push   $0x8010ffc0
80100ddf:	e8 ec 36 00 00       	call   801044d0 <acquire>
  if(f->ref < 1)
80100de4:	8b 43 04             	mov    0x4(%ebx),%eax
80100de7:	83 c4 10             	add    $0x10,%esp
80100dea:	85 c0                	test   %eax,%eax
80100dec:	7e 1a                	jle    80100e08 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100df1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100df4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100df7:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dfc:	e8 ef 37 00 00       	call   801045f0 <release>
  return f;
}
80100e01:	89 d8                	mov    %ebx,%eax
80100e03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e06:	c9                   	leave  
80100e07:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e08:	83 ec 0c             	sub    $0xc,%esp
80100e0b:	68 94 72 10 80       	push   $0x80107294
80100e10:	e8 5b f5 ff ff       	call   80100370 <panic>
80100e15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e20 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	57                   	push   %edi
80100e24:	56                   	push   %esi
80100e25:	53                   	push   %ebx
80100e26:	83 ec 28             	sub    $0x28,%esp
80100e29:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e2c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e31:	e8 9a 36 00 00       	call   801044d0 <acquire>
  if(f->ref < 1)
80100e36:	8b 47 04             	mov    0x4(%edi),%eax
80100e39:	83 c4 10             	add    $0x10,%esp
80100e3c:	85 c0                	test   %eax,%eax
80100e3e:	0f 8e 9b 00 00 00    	jle    80100edf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e44:	83 e8 01             	sub    $0x1,%eax
80100e47:	85 c0                	test   %eax,%eax
80100e49:	89 47 04             	mov    %eax,0x4(%edi)
80100e4c:	74 1a                	je     80100e68 <fileclose+0x48>
    release(&ftable.lock);
80100e4e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e58:	5b                   	pop    %ebx
80100e59:	5e                   	pop    %esi
80100e5a:	5f                   	pop    %edi
80100e5b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e5c:	e9 8f 37 00 00       	jmp    801045f0 <release>
80100e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e68:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e6c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e6e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e71:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e74:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e7a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e7d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e80:	68 c0 ff 10 80       	push   $0x8010ffc0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e85:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e88:	e8 63 37 00 00       	call   801045f0 <release>

  if(ff.type == FD_PIPE)
80100e8d:	83 c4 10             	add    $0x10,%esp
80100e90:	83 fb 01             	cmp    $0x1,%ebx
80100e93:	74 13                	je     80100ea8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e95:	83 fb 02             	cmp    $0x2,%ebx
80100e98:	74 26                	je     80100ec0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e9d:	5b                   	pop    %ebx
80100e9e:	5e                   	pop    %esi
80100e9f:	5f                   	pop    %edi
80100ea0:	5d                   	pop    %ebp
80100ea1:	c3                   	ret    
80100ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100ea8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100eac:	83 ec 08             	sub    $0x8,%esp
80100eaf:	53                   	push   %ebx
80100eb0:	56                   	push   %esi
80100eb1:	e8 2a 25 00 00       	call   801033e0 <pipeclose>
80100eb6:	83 c4 10             	add    $0x10,%esp
80100eb9:	eb df                	jmp    80100e9a <fileclose+0x7a>
80100ebb:	90                   	nop
80100ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ec0:	e8 ab 1c 00 00       	call   80102b70 <begin_op>
    iput(ff.ip);
80100ec5:	83 ec 0c             	sub    $0xc,%esp
80100ec8:	ff 75 e0             	pushl  -0x20(%ebp)
80100ecb:	e8 d0 08 00 00       	call   801017a0 <iput>
    end_op();
80100ed0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ed3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ed6:	5b                   	pop    %ebx
80100ed7:	5e                   	pop    %esi
80100ed8:	5f                   	pop    %edi
80100ed9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eda:	e9 01 1d 00 00       	jmp    80102be0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100edf:	83 ec 0c             	sub    $0xc,%esp
80100ee2:	68 9c 72 10 80       	push   $0x8010729c
80100ee7:	e8 84 f4 ff ff       	call   80100370 <panic>
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 04             	sub    $0x4,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100efa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100efd:	75 31                	jne    80100f30 <filestat+0x40>
    ilock(f->ip);
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	ff 73 10             	pushl  0x10(%ebx)
80100f05:	e8 66 07 00 00       	call   80101670 <ilock>
    stati(f->ip, st);
80100f0a:	58                   	pop    %eax
80100f0b:	5a                   	pop    %edx
80100f0c:	ff 75 0c             	pushl  0xc(%ebp)
80100f0f:	ff 73 10             	pushl  0x10(%ebx)
80100f12:	e8 e9 09 00 00       	call   80101900 <stati>
    iunlock(f->ip);
80100f17:	59                   	pop    %ecx
80100f18:	ff 73 10             	pushl  0x10(%ebx)
80100f1b:	e8 30 08 00 00       	call   80101750 <iunlock>
    return 0;
80100f20:	83 c4 10             	add    $0x10,%esp
80100f23:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f28:	c9                   	leave  
80100f29:	c3                   	ret    
80100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	83 ec 0c             	sub    $0xc,%esp
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f4f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f56:	74 60                	je     80100fb8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f58:	8b 03                	mov    (%ebx),%eax
80100f5a:	83 f8 01             	cmp    $0x1,%eax
80100f5d:	74 41                	je     80100fa0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f5f:	83 f8 02             	cmp    $0x2,%eax
80100f62:	75 5b                	jne    80100fbf <fileread+0x7f>
    ilock(f->ip);
80100f64:	83 ec 0c             	sub    $0xc,%esp
80100f67:	ff 73 10             	pushl  0x10(%ebx)
80100f6a:	e8 01 07 00 00       	call   80101670 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f6f:	57                   	push   %edi
80100f70:	ff 73 14             	pushl  0x14(%ebx)
80100f73:	56                   	push   %esi
80100f74:	ff 73 10             	pushl  0x10(%ebx)
80100f77:	e8 b4 09 00 00       	call   80101930 <readi>
80100f7c:	83 c4 20             	add    $0x20,%esp
80100f7f:	85 c0                	test   %eax,%eax
80100f81:	89 c6                	mov    %eax,%esi
80100f83:	7e 03                	jle    80100f88 <fileread+0x48>
      f->off += r;
80100f85:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f88:	83 ec 0c             	sub    $0xc,%esp
80100f8b:	ff 73 10             	pushl  0x10(%ebx)
80100f8e:	e8 bd 07 00 00       	call   80101750 <iunlock>
    return r;
80100f93:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100f96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f99:	89 f0                	mov    %esi,%eax
80100f9b:	5b                   	pop    %ebx
80100f9c:	5e                   	pop    %esi
80100f9d:	5f                   	pop    %edi
80100f9e:	5d                   	pop    %ebp
80100f9f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fa0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fa3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa9:	5b                   	pop    %ebx
80100faa:	5e                   	pop    %esi
80100fab:	5f                   	pop    %edi
80100fac:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fad:	e9 de 25 00 00       	jmp    80103590 <piperead>
80100fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fb8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fbd:	eb d7                	jmp    80100f96 <fileread+0x56>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fbf:	83 ec 0c             	sub    $0xc,%esp
80100fc2:	68 a6 72 10 80       	push   $0x801072a6
80100fc7:	e8 a4 f3 ff ff       	call   80100370 <panic>
80100fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	57                   	push   %edi
80100fd4:	56                   	push   %esi
80100fd5:	53                   	push   %ebx
80100fd6:	83 ec 1c             	sub    $0x1c,%esp
80100fd9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fdf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100fe6:	8b 45 10             	mov    0x10(%ebp),%eax
80100fe9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100fec:	0f 84 aa 00 00 00    	je     8010109c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80100ff2:	8b 06                	mov    (%esi),%eax
80100ff4:	83 f8 01             	cmp    $0x1,%eax
80100ff7:	0f 84 c2 00 00 00    	je     801010bf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100ffd:	83 f8 02             	cmp    $0x2,%eax
80101000:	0f 85 e4 00 00 00    	jne    801010ea <filewrite+0x11a>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101006:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101009:	31 ff                	xor    %edi,%edi
8010100b:	85 c0                	test   %eax,%eax
8010100d:	7f 34                	jg     80101043 <filewrite+0x73>
8010100f:	e9 9c 00 00 00       	jmp    801010b0 <filewrite+0xe0>
80101014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101018:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010101b:	83 ec 0c             	sub    $0xc,%esp
8010101e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101021:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101024:	e8 27 07 00 00       	call   80101750 <iunlock>
      end_op();
80101029:	e8 b2 1b 00 00       	call   80102be0 <end_op>
8010102e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101031:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101034:	39 d8                	cmp    %ebx,%eax
80101036:	0f 85 a1 00 00 00    	jne    801010dd <filewrite+0x10d>
        panic("short filewrite");
      i += r;
8010103c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010103e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101041:	7e 6d                	jle    801010b0 <filewrite+0xe0>
      int n1 = n - i;
80101043:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101046:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010104b:	29 fb                	sub    %edi,%ebx
8010104d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101053:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101056:	e8 15 1b 00 00       	call   80102b70 <begin_op>
      ilock(f->ip);
8010105b:	83 ec 0c             	sub    $0xc,%esp
8010105e:	ff 76 10             	pushl  0x10(%esi)
80101061:	e8 0a 06 00 00       	call   80101670 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101066:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101069:	53                   	push   %ebx
8010106a:	ff 76 14             	pushl  0x14(%esi)
8010106d:	01 f8                	add    %edi,%eax
8010106f:	50                   	push   %eax
80101070:	ff 76 10             	pushl  0x10(%esi)
80101073:	e8 b8 09 00 00       	call   80101a30 <writei>
80101078:	83 c4 20             	add    $0x20,%esp
8010107b:	85 c0                	test   %eax,%eax
8010107d:	7f 99                	jg     80101018 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010107f:	83 ec 0c             	sub    $0xc,%esp
80101082:	ff 76 10             	pushl  0x10(%esi)
80101085:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101088:	e8 c3 06 00 00       	call   80101750 <iunlock>
      end_op();
8010108d:	e8 4e 1b 00 00       	call   80102be0 <end_op>

      if(r < 0)
80101092:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101095:	83 c4 10             	add    $0x10,%esp
80101098:	85 c0                	test   %eax,%eax
8010109a:	74 98                	je     80101034 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010109c:	8d 65 f4             	lea    -0xc(%ebp),%esp
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
8010109f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010a4:	5b                   	pop    %ebx
801010a5:	5e                   	pop    %esi
801010a6:	5f                   	pop    %edi
801010a7:	5d                   	pop    %ebp
801010a8:	c3                   	ret    
801010a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010b0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010b3:	75 e7                	jne    8010109c <filewrite+0xcc>
  }
  panic("filewrite");
}
801010b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010b8:	89 f8                	mov    %edi,%eax
801010ba:	5b                   	pop    %ebx
801010bb:	5e                   	pop    %esi
801010bc:	5f                   	pop    %edi
801010bd:	5d                   	pop    %ebp
801010be:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010c2:	89 45 10             	mov    %eax,0x10(%ebp)
801010c5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010c8:	89 45 0c             	mov    %eax,0xc(%ebp)
801010cb:	8b 46 0c             	mov    0xc(%esi),%eax
801010ce:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d4:	5b                   	pop    %ebx
801010d5:	5e                   	pop    %esi
801010d6:	5f                   	pop    %edi
801010d7:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010d8:	e9 a3 23 00 00       	jmp    80103480 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010dd:	83 ec 0c             	sub    $0xc,%esp
801010e0:	68 af 72 10 80       	push   $0x801072af
801010e5:	e8 86 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ea:	83 ec 0c             	sub    $0xc,%esp
801010ed:	68 b5 72 10 80       	push   $0x801072b5
801010f2:	e8 79 f2 ff ff       	call   80100370 <panic>
801010f7:	66 90                	xchg   %ax,%ax
801010f9:	66 90                	xchg   %ax,%ax
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101109:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010110f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101112:	85 c9                	test   %ecx,%ecx
80101114:	0f 84 87 00 00 00    	je     801011a1 <balloc+0xa1>
8010111a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101121:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101124:	83 ec 08             	sub    $0x8,%esp
80101127:	89 f0                	mov    %esi,%eax
80101129:	c1 f8 0c             	sar    $0xc,%eax
8010112c:	03 05 d8 09 11 80    	add    0x801109d8,%eax
80101132:	50                   	push   %eax
80101133:	ff 75 d8             	pushl  -0x28(%ebp)
80101136:	e8 95 ef ff ff       	call   801000d0 <bread>
8010113b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010113e:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101143:	83 c4 10             	add    $0x10,%esp
80101146:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101149:	31 c0                	xor    %eax,%eax
8010114b:	eb 2f                	jmp    8010117c <balloc+0x7c>
8010114d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101150:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101152:	8b 55 e4             	mov    -0x1c(%ebp),%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101155:	bb 01 00 00 00       	mov    $0x1,%ebx
8010115a:	83 e1 07             	and    $0x7,%ecx
8010115d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010115f:	89 c1                	mov    %eax,%ecx
80101161:	c1 f9 03             	sar    $0x3,%ecx
80101164:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101169:	85 df                	test   %ebx,%edi
8010116b:	89 fa                	mov    %edi,%edx
8010116d:	74 41                	je     801011b0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010116f:	83 c0 01             	add    $0x1,%eax
80101172:	83 c6 01             	add    $0x1,%esi
80101175:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010117a:	74 05                	je     80101181 <balloc+0x81>
8010117c:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010117f:	72 cf                	jb     80101150 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101181:	83 ec 0c             	sub    $0xc,%esp
80101184:	ff 75 e4             	pushl  -0x1c(%ebp)
80101187:	e8 54 f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010118c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101193:	83 c4 10             	add    $0x10,%esp
80101196:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101199:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010119f:	77 80                	ja     80101121 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801011a1:	83 ec 0c             	sub    $0xc,%esp
801011a4:	68 bf 72 10 80       	push   $0x801072bf
801011a9:	e8 c2 f1 ff ff       	call   80100370 <panic>
801011ae:	66 90                	xchg   %ax,%ax
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011b0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011b3:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011b6:	09 da                	or     %ebx,%edx
801011b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011bc:	57                   	push   %edi
801011bd:	e8 8e 1b 00 00       	call   80102d50 <log_write>
        brelse(bp);
801011c2:	89 3c 24             	mov    %edi,(%esp)
801011c5:	e8 16 f0 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011ca:	58                   	pop    %eax
801011cb:	5a                   	pop    %edx
801011cc:	56                   	push   %esi
801011cd:	ff 75 d8             	pushl  -0x28(%ebp)
801011d0:	e8 fb ee ff ff       	call   801000d0 <bread>
801011d5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011da:	83 c4 0c             	add    $0xc,%esp
801011dd:	68 00 02 00 00       	push   $0x200
801011e2:	6a 00                	push   $0x0
801011e4:	50                   	push   %eax
801011e5:	e8 56 34 00 00       	call   80104640 <memset>
  log_write(bp);
801011ea:	89 1c 24             	mov    %ebx,(%esp)
801011ed:	e8 5e 1b 00 00       	call   80102d50 <log_write>
  brelse(bp);
801011f2:	89 1c 24             	mov    %ebx,(%esp)
801011f5:	e8 e6 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801011fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fd:	89 f0                	mov    %esi,%eax
801011ff:	5b                   	pop    %ebx
80101200:	5e                   	pop    %esi
80101201:	5f                   	pop    %edi
80101202:	5d                   	pop    %ebp
80101203:	c3                   	ret    
80101204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010120a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101210 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101218:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010121a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010121f:	83 ec 28             	sub    $0x28,%esp
80101222:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101225:	68 e0 09 11 80       	push   $0x801109e0
8010122a:	e8 a1 32 00 00       	call   801044d0 <acquire>
8010122f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101232:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101235:	eb 1b                	jmp    80101252 <iget+0x42>
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101240:	85 f6                	test   %esi,%esi
80101242:	74 44                	je     80101288 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101244:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010124a:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101250:	73 4e                	jae    801012a0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101252:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101255:	85 c9                	test   %ecx,%ecx
80101257:	7e e7                	jle    80101240 <iget+0x30>
80101259:	39 3b                	cmp    %edi,(%ebx)
8010125b:	75 e3                	jne    80101240 <iget+0x30>
8010125d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101260:	75 de                	jne    80101240 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101262:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101265:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101268:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010126a:	68 e0 09 11 80       	push   $0x801109e0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010126f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101272:	e8 79 33 00 00       	call   801045f0 <release>
      return ip;
80101277:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101288:	85 c9                	test   %ecx,%ecx
8010128a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010128d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101293:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101299:	72 b7                	jb     80101252 <iget+0x42>
8010129b:	90                   	nop
8010129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 2d                	je     801012d1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
801012a4:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012a7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012a9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012ac:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
801012b3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012ba:	68 e0 09 11 80       	push   $0x801109e0
801012bf:	e8 2c 33 00 00       	call   801045f0 <release>

  return ip;
801012c4:	83 c4 10             	add    $0x10,%esp
}
801012c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012d1:	83 ec 0c             	sub    $0xc,%esp
801012d4:	68 d5 72 10 80       	push   $0x801072d5
801012d9:	e8 92 f0 ff ff       	call   80100370 <panic>
801012de:	66 90                	xchg   %ax,%ax

801012e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	89 c6                	mov    %eax,%esi
801012e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012eb:	83 fa 0b             	cmp    $0xb,%edx
801012ee:	77 18                	ja     80101308 <bmap+0x28>
801012f0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801012f3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801012f6:	85 db                	test   %ebx,%ebx
801012f8:	74 76                	je     80101370 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012fd:	89 d8                	mov    %ebx,%eax
801012ff:	5b                   	pop    %ebx
80101300:	5e                   	pop    %esi
80101301:	5f                   	pop    %edi
80101302:	5d                   	pop    %ebp
80101303:	c3                   	ret    
80101304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101308:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010130b:	83 fb 7f             	cmp    $0x7f,%ebx
8010130e:	0f 87 8e 00 00 00    	ja     801013a2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101314:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010131a:	85 c0                	test   %eax,%eax
8010131c:	74 72                	je     80101390 <bmap+0xb0>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010131e:	83 ec 08             	sub    $0x8,%esp
80101321:	50                   	push   %eax
80101322:	ff 36                	pushl  (%esi)
80101324:	e8 a7 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101329:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010132d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101330:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101332:	8b 1a                	mov    (%edx),%ebx
80101334:	85 db                	test   %ebx,%ebx
80101336:	75 1d                	jne    80101355 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101338:	8b 06                	mov    (%esi),%eax
8010133a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010133d:	e8 be fd ff ff       	call   80101100 <balloc>
80101342:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101345:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101348:	89 c3                	mov    %eax,%ebx
8010134a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010134c:	57                   	push   %edi
8010134d:	e8 fe 19 00 00       	call   80102d50 <log_write>
80101352:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101355:	83 ec 0c             	sub    $0xc,%esp
80101358:	57                   	push   %edi
80101359:	e8 82 ee ff ff       	call   801001e0 <brelse>
8010135e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101364:	89 d8                	mov    %ebx,%eax
80101366:	5b                   	pop    %ebx
80101367:	5e                   	pop    %esi
80101368:	5f                   	pop    %edi
80101369:	5d                   	pop    %ebp
8010136a:	c3                   	ret    
8010136b:	90                   	nop
8010136c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101370:	8b 00                	mov    (%eax),%eax
80101372:	e8 89 fd ff ff       	call   80101100 <balloc>
80101377:	89 47 5c             	mov    %eax,0x5c(%edi)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
8010137d:	89 c3                	mov    %eax,%ebx
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137f:	89 d8                	mov    %ebx,%eax
80101381:	5b                   	pop    %ebx
80101382:	5e                   	pop    %esi
80101383:	5f                   	pop    %edi
80101384:	5d                   	pop    %ebp
80101385:	c3                   	ret    
80101386:	8d 76 00             	lea    0x0(%esi),%esi
80101389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101390:	8b 06                	mov    (%esi),%eax
80101392:	e8 69 fd ff ff       	call   80101100 <balloc>
80101397:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010139d:	e9 7c ff ff ff       	jmp    8010131e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801013a2:	83 ec 0c             	sub    $0xc,%esp
801013a5:	68 e5 72 10 80       	push   $0x801072e5
801013aa:	e8 c1 ef ff ff       	call   80100370 <panic>
801013af:	90                   	nop

801013b0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	56                   	push   %esi
801013b4:	53                   	push   %ebx
801013b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013b8:	83 ec 08             	sub    $0x8,%esp
801013bb:	6a 01                	push   $0x1
801013bd:	ff 75 08             	pushl  0x8(%ebp)
801013c0:	e8 0b ed ff ff       	call   801000d0 <bread>
801013c5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ca:	83 c4 0c             	add    $0xc,%esp
801013cd:	6a 1c                	push   $0x1c
801013cf:	50                   	push   %eax
801013d0:	56                   	push   %esi
801013d1:	e8 1a 33 00 00       	call   801046f0 <memmove>
  brelse(bp);
801013d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013d9:	83 c4 10             	add    $0x10,%esp
}
801013dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013df:	5b                   	pop    %ebx
801013e0:	5e                   	pop    %esi
801013e1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013e2:	e9 f9 ed ff ff       	jmp    801001e0 <brelse>
801013e7:	89 f6                	mov    %esi,%esi
801013e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	56                   	push   %esi
801013f4:	53                   	push   %ebx
801013f5:	89 d3                	mov    %edx,%ebx
801013f7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013f9:	83 ec 08             	sub    $0x8,%esp
801013fc:	68 c0 09 11 80       	push   $0x801109c0
80101401:	50                   	push   %eax
80101402:	e8 a9 ff ff ff       	call   801013b0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101407:	58                   	pop    %eax
80101408:	5a                   	pop    %edx
80101409:	89 da                	mov    %ebx,%edx
8010140b:	c1 ea 0c             	shr    $0xc,%edx
8010140e:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101414:	52                   	push   %edx
80101415:	56                   	push   %esi
80101416:	e8 b5 ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010141b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010141d:	c1 fb 03             	sar    $0x3,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101420:	ba 01 00 00 00       	mov    $0x1,%edx
80101425:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101428:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010142e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101431:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101433:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101438:	85 d1                	test   %edx,%ecx
8010143a:	74 25                	je     80101461 <bfree+0x71>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010143c:	f7 d2                	not    %edx
8010143e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101440:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101443:	21 ca                	and    %ecx,%edx
80101445:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101449:	56                   	push   %esi
8010144a:	e8 01 19 00 00       	call   80102d50 <log_write>
  brelse(bp);
8010144f:	89 34 24             	mov    %esi,(%esp)
80101452:	e8 89 ed ff ff       	call   801001e0 <brelse>
}
80101457:	83 c4 10             	add    $0x10,%esp
8010145a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010145d:	5b                   	pop    %ebx
8010145e:	5e                   	pop    %esi
8010145f:	5d                   	pop    %ebp
80101460:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101461:	83 ec 0c             	sub    $0xc,%esp
80101464:	68 f8 72 10 80       	push   $0x801072f8
80101469:	e8 02 ef ff ff       	call   80100370 <panic>
8010146e:	66 90                	xchg   %ax,%ax

80101470 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101479:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010147c:	68 0b 73 10 80       	push   $0x8010730b
80101481:	68 e0 09 11 80       	push   $0x801109e0
80101486:	e8 45 2f 00 00       	call   801043d0 <initlock>
8010148b:	83 c4 10             	add    $0x10,%esp
8010148e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101490:	83 ec 08             	sub    $0x8,%esp
80101493:	68 12 73 10 80       	push   $0x80107312
80101498:	53                   	push   %ebx
80101499:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010149f:	e8 1c 2e 00 00       	call   801042c0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014a4:	83 c4 10             	add    $0x10,%esp
801014a7:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014ad:	75 e1                	jne    80101490 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801014af:	83 ec 08             	sub    $0x8,%esp
801014b2:	68 c0 09 11 80       	push   $0x801109c0
801014b7:	ff 75 08             	pushl  0x8(%ebp)
801014ba:	e8 f1 fe ff ff       	call   801013b0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014bf:	ff 35 d8 09 11 80    	pushl  0x801109d8
801014c5:	ff 35 d4 09 11 80    	pushl  0x801109d4
801014cb:	ff 35 d0 09 11 80    	pushl  0x801109d0
801014d1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801014d7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801014dd:	ff 35 c4 09 11 80    	pushl  0x801109c4
801014e3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801014e9:	68 78 73 10 80       	push   $0x80107378
801014ee:	e8 6d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801014f3:	83 c4 30             	add    $0x30,%esp
801014f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014f9:	c9                   	leave  
801014fa:	c3                   	ret    
801014fb:	90                   	nop
801014fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101500 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	57                   	push   %edi
80101504:	56                   	push   %esi
80101505:	53                   	push   %ebx
80101506:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101509:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101510:	8b 45 0c             	mov    0xc(%ebp),%eax
80101513:	8b 75 08             	mov    0x8(%ebp),%esi
80101516:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	0f 86 91 00 00 00    	jbe    801015b0 <ialloc+0xb0>
8010151f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101524:	eb 21                	jmp    80101547 <ialloc+0x47>
80101526:	8d 76 00             	lea    0x0(%esi),%esi
80101529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101530:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101533:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101536:	57                   	push   %edi
80101537:	e8 a4 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010153c:	83 c4 10             	add    $0x10,%esp
8010153f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101545:	76 69                	jbe    801015b0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101547:	89 d8                	mov    %ebx,%eax
80101549:	83 ec 08             	sub    $0x8,%esp
8010154c:	c1 e8 03             	shr    $0x3,%eax
8010154f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101555:	50                   	push   %eax
80101556:	56                   	push   %esi
80101557:	e8 74 eb ff ff       	call   801000d0 <bread>
8010155c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010155e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101560:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101563:	83 e0 07             	and    $0x7,%eax
80101566:	c1 e0 06             	shl    $0x6,%eax
80101569:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010156d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101571:	75 bd                	jne    80101530 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101573:	83 ec 04             	sub    $0x4,%esp
80101576:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101579:	6a 40                	push   $0x40
8010157b:	6a 00                	push   $0x0
8010157d:	51                   	push   %ecx
8010157e:	e8 bd 30 00 00       	call   80104640 <memset>
      dip->type = type;
80101583:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101587:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010158a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010158d:	89 3c 24             	mov    %edi,(%esp)
80101590:	e8 bb 17 00 00       	call   80102d50 <log_write>
      brelse(bp);
80101595:	89 3c 24             	mov    %edi,(%esp)
80101598:	e8 43 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010159d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015a3:	89 da                	mov    %ebx,%edx
801015a5:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015a7:	5b                   	pop    %ebx
801015a8:	5e                   	pop    %esi
801015a9:	5f                   	pop    %edi
801015aa:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015ab:	e9 60 fc ff ff       	jmp    80101210 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015b0:	83 ec 0c             	sub    $0xc,%esp
801015b3:	68 18 73 10 80       	push   $0x80107318
801015b8:	e8 b3 ed ff ff       	call   80100370 <panic>
801015bd:	8d 76 00             	lea    0x0(%esi),%esi

801015c0 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	56                   	push   %esi
801015c4:	53                   	push   %ebx
801015c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015c8:	83 ec 08             	sub    $0x8,%esp
801015cb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ce:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d1:	c1 e8 03             	shr    $0x3,%eax
801015d4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801015da:	50                   	push   %eax
801015db:	ff 73 a4             	pushl  -0x5c(%ebx)
801015de:	e8 ed ea ff ff       	call   801000d0 <bread>
801015e3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015e5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015e8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ec:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ef:	83 e0 07             	and    $0x7,%eax
801015f2:	c1 e0 06             	shl    $0x6,%eax
801015f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015f9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015fc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101600:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101603:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101607:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010160b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010160f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101613:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101617:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010161a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010161d:	6a 34                	push   $0x34
8010161f:	53                   	push   %ebx
80101620:	50                   	push   %eax
80101621:	e8 ca 30 00 00       	call   801046f0 <memmove>
  log_write(bp);
80101626:	89 34 24             	mov    %esi,(%esp)
80101629:	e8 22 17 00 00       	call   80102d50 <log_write>
  brelse(bp);
8010162e:	89 75 08             	mov    %esi,0x8(%ebp)
80101631:	83 c4 10             	add    $0x10,%esp
}
80101634:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101637:	5b                   	pop    %ebx
80101638:	5e                   	pop    %esi
80101639:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010163a:	e9 a1 eb ff ff       	jmp    801001e0 <brelse>
8010163f:	90                   	nop

80101640 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	53                   	push   %ebx
80101644:	83 ec 10             	sub    $0x10,%esp
80101647:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010164a:	68 e0 09 11 80       	push   $0x801109e0
8010164f:	e8 7c 2e 00 00       	call   801044d0 <acquire>
  ip->ref++;
80101654:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101658:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010165f:	e8 8c 2f 00 00       	call   801045f0 <release>
  return ip;
}
80101664:	89 d8                	mov    %ebx,%eax
80101666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101669:	c9                   	leave  
8010166a:	c3                   	ret    
8010166b:	90                   	nop
8010166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101670 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	56                   	push   %esi
80101674:	53                   	push   %ebx
80101675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101678:	85 db                	test   %ebx,%ebx
8010167a:	0f 84 b4 00 00 00    	je     80101734 <ilock+0xc4>
80101680:	8b 43 08             	mov    0x8(%ebx),%eax
80101683:	85 c0                	test   %eax,%eax
80101685:	0f 8e a9 00 00 00    	jle    80101734 <ilock+0xc4>
    panic("ilock");

  acquiresleep(&ip->lock);
8010168b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010168e:	83 ec 0c             	sub    $0xc,%esp
80101691:	50                   	push   %eax
80101692:	e8 69 2c 00 00       	call   80104300 <acquiresleep>

  if(!(ip->flags & I_VALID)){
80101697:	83 c4 10             	add    $0x10,%esp
8010169a:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
8010169e:	74 10                	je     801016b0 <ilock+0x40>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801016a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016a3:	5b                   	pop    %ebx
801016a4:	5e                   	pop    %esi
801016a5:	5d                   	pop    %ebp
801016a6:	c3                   	ret    
801016a7:	89 f6                	mov    %esi,%esi
801016a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016b0:	8b 43 04             	mov    0x4(%ebx),%eax
801016b3:	83 ec 08             	sub    $0x8,%esp
801016b6:	c1 e8 03             	shr    $0x3,%eax
801016b9:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016bf:	50                   	push   %eax
801016c0:	ff 33                	pushl  (%ebx)
801016c2:	e8 09 ea ff ff       	call   801000d0 <bread>
801016c7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016c9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016cc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016cf:	83 e0 07             	and    $0x7,%eax
801016d2:	c1 e0 06             	shl    $0x6,%eax
801016d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016d9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016dc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016df:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016e3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016e7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016eb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016ef:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016f3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016f7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016fb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016fe:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101701:	6a 34                	push   $0x34
80101703:	50                   	push   %eax
80101704:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101707:	50                   	push   %eax
80101708:	e8 e3 2f 00 00       	call   801046f0 <memmove>
    brelse(bp);
8010170d:	89 34 24             	mov    %esi,(%esp)
80101710:	e8 cb ea ff ff       	call   801001e0 <brelse>
    ip->flags |= I_VALID;
80101715:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
80101719:	83 c4 10             	add    $0x10,%esp
8010171c:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101721:	0f 85 79 ff ff ff    	jne    801016a0 <ilock+0x30>
      panic("ilock: no type");
80101727:	83 ec 0c             	sub    $0xc,%esp
8010172a:	68 30 73 10 80       	push   $0x80107330
8010172f:	e8 3c ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101734:	83 ec 0c             	sub    $0xc,%esp
80101737:	68 2a 73 10 80       	push   $0x8010732a
8010173c:	e8 2f ec ff ff       	call   80100370 <panic>
80101741:	eb 0d                	jmp    80101750 <iunlock>
80101743:	90                   	nop
80101744:	90                   	nop
80101745:	90                   	nop
80101746:	90                   	nop
80101747:	90                   	nop
80101748:	90                   	nop
80101749:	90                   	nop
8010174a:	90                   	nop
8010174b:	90                   	nop
8010174c:	90                   	nop
8010174d:	90                   	nop
8010174e:	90                   	nop
8010174f:	90                   	nop

80101750 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101758:	85 db                	test   %ebx,%ebx
8010175a:	74 28                	je     80101784 <iunlock+0x34>
8010175c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010175f:	83 ec 0c             	sub    $0xc,%esp
80101762:	56                   	push   %esi
80101763:	e8 38 2c 00 00       	call   801043a0 <holdingsleep>
80101768:	83 c4 10             	add    $0x10,%esp
8010176b:	85 c0                	test   %eax,%eax
8010176d:	74 15                	je     80101784 <iunlock+0x34>
8010176f:	8b 43 08             	mov    0x8(%ebx),%eax
80101772:	85 c0                	test   %eax,%eax
80101774:	7e 0e                	jle    80101784 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101776:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101779:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010177c:	5b                   	pop    %ebx
8010177d:	5e                   	pop    %esi
8010177e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010177f:	e9 dc 2b 00 00       	jmp    80104360 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101784:	83 ec 0c             	sub    $0xc,%esp
80101787:	68 3f 73 10 80       	push   $0x8010733f
8010178c:	e8 df eb ff ff       	call   80100370 <panic>
80101791:	eb 0d                	jmp    801017a0 <iput>
80101793:	90                   	nop
80101794:	90                   	nop
80101795:	90                   	nop
80101796:	90                   	nop
80101797:	90                   	nop
80101798:	90                   	nop
80101799:	90                   	nop
8010179a:	90                   	nop
8010179b:	90                   	nop
8010179c:	90                   	nop
8010179d:	90                   	nop
8010179e:	90                   	nop
8010179f:	90                   	nop

801017a0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	57                   	push   %edi
801017a4:	56                   	push   %esi
801017a5:	53                   	push   %ebx
801017a6:	83 ec 28             	sub    $0x28,%esp
801017a9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
801017ac:	68 e0 09 11 80       	push   $0x801109e0
801017b1:	e8 1a 2d 00 00       	call   801044d0 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017b6:	8b 46 08             	mov    0x8(%esi),%eax
801017b9:	83 c4 10             	add    $0x10,%esp
801017bc:	83 f8 01             	cmp    $0x1,%eax
801017bf:	74 1f                	je     801017e0 <iput+0x40>
    ip->type = 0;
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
801017c1:	83 e8 01             	sub    $0x1,%eax
801017c4:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801017c7:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801017ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017d1:	5b                   	pop    %ebx
801017d2:	5e                   	pop    %esi
801017d3:	5f                   	pop    %edi
801017d4:	5d                   	pop    %ebp
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
  release(&icache.lock);
801017d5:	e9 16 2e 00 00       	jmp    801045f0 <release>
801017da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// case it has to free the inode.
void
iput(struct inode *ip)
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017e0:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
801017e4:	74 db                	je     801017c1 <iput+0x21>
801017e6:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017eb:	75 d4                	jne    801017c1 <iput+0x21>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
801017ed:	83 ec 0c             	sub    $0xc,%esp
801017f0:	8d 5e 5c             	lea    0x5c(%esi),%ebx
801017f3:	8d be 8c 00 00 00    	lea    0x8c(%esi),%edi
801017f9:	68 e0 09 11 80       	push   $0x801109e0
801017fe:	e8 ed 2d 00 00       	call   801045f0 <release>
80101803:	83 c4 10             	add    $0x10,%esp
80101806:	eb 0f                	jmp    80101817 <iput+0x77>
80101808:	90                   	nop
80101809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101810:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101813:	39 fb                	cmp    %edi,%ebx
80101815:	74 19                	je     80101830 <iput+0x90>
    if(ip->addrs[i]){
80101817:	8b 13                	mov    (%ebx),%edx
80101819:	85 d2                	test   %edx,%edx
8010181b:	74 f3                	je     80101810 <iput+0x70>
      bfree(ip->dev, ip->addrs[i]);
8010181d:	8b 06                	mov    (%esi),%eax
8010181f:	e8 cc fb ff ff       	call   801013f0 <bfree>
      ip->addrs[i] = 0;
80101824:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010182a:	eb e4                	jmp    80101810 <iput+0x70>
8010182c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101830:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101836:	85 c0                	test   %eax,%eax
80101838:	75 46                	jne    80101880 <iput+0xe0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010183a:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010183d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101844:	56                   	push   %esi
80101845:	e8 76 fd ff ff       	call   801015c0 <iupdate>
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
8010184a:	31 c0                	xor    %eax,%eax
8010184c:	66 89 46 50          	mov    %ax,0x50(%esi)
    iupdate(ip);
80101850:	89 34 24             	mov    %esi,(%esp)
80101853:	e8 68 fd ff ff       	call   801015c0 <iupdate>
    acquire(&icache.lock);
80101858:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010185f:	e8 6c 2c 00 00       	call   801044d0 <acquire>
    ip->flags = 0;
80101864:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
8010186b:	8b 46 08             	mov    0x8(%esi),%eax
8010186e:	83 c4 10             	add    $0x10,%esp
80101871:	e9 4b ff ff ff       	jmp    801017c1 <iput+0x21>
80101876:	8d 76 00             	lea    0x0(%esi),%esi
80101879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101880:	83 ec 08             	sub    $0x8,%esp
80101883:	50                   	push   %eax
80101884:	ff 36                	pushl  (%esi)
80101886:	e8 45 e8 ff ff       	call   801000d0 <bread>
8010188b:	83 c4 10             	add    $0x10,%esp
8010188e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101891:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101894:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
8010189a:	eb 0b                	jmp    801018a7 <iput+0x107>
8010189c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018a0:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
801018a3:	39 df                	cmp    %ebx,%edi
801018a5:	74 0f                	je     801018b6 <iput+0x116>
      if(a[j])
801018a7:	8b 13                	mov    (%ebx),%edx
801018a9:	85 d2                	test   %edx,%edx
801018ab:	74 f3                	je     801018a0 <iput+0x100>
        bfree(ip->dev, a[j]);
801018ad:	8b 06                	mov    (%esi),%eax
801018af:	e8 3c fb ff ff       	call   801013f0 <bfree>
801018b4:	eb ea                	jmp    801018a0 <iput+0x100>
    }
    brelse(bp);
801018b6:	83 ec 0c             	sub    $0xc,%esp
801018b9:	ff 75 e4             	pushl  -0x1c(%ebp)
801018bc:	e8 1f e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018c1:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018c7:	8b 06                	mov    (%esi),%eax
801018c9:	e8 22 fb ff ff       	call   801013f0 <bfree>
    ip->addrs[NDIRECT] = 0;
801018ce:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018d5:	00 00 00 
801018d8:	83 c4 10             	add    $0x10,%esp
801018db:	e9 5a ff ff ff       	jmp    8010183a <iput+0x9a>

801018e0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	53                   	push   %ebx
801018e4:	83 ec 10             	sub    $0x10,%esp
801018e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801018ea:	53                   	push   %ebx
801018eb:	e8 60 fe ff ff       	call   80101750 <iunlock>
  iput(ip);
801018f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801018f3:	83 c4 10             	add    $0x10,%esp
}
801018f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018f9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801018fa:	e9 a1 fe ff ff       	jmp    801017a0 <iput>
801018ff:	90                   	nop

80101900 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101900:	55                   	push   %ebp
80101901:	89 e5                	mov    %esp,%ebp
80101903:	8b 55 08             	mov    0x8(%ebp),%edx
80101906:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101909:	8b 0a                	mov    (%edx),%ecx
8010190b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010190e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101911:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101914:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101918:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010191b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010191f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101923:	8b 52 58             	mov    0x58(%edx),%edx
80101926:	89 50 10             	mov    %edx,0x10(%eax)
}
80101929:	5d                   	pop    %ebp
8010192a:	c3                   	ret    
8010192b:	90                   	nop
8010192c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101930 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	57                   	push   %edi
80101934:	56                   	push   %esi
80101935:	53                   	push   %ebx
80101936:	83 ec 1c             	sub    $0x1c,%esp
80101939:	8b 45 08             	mov    0x8(%ebp),%eax
8010193c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010193f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101942:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101947:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010194a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010194d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101950:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101953:	0f 84 a7 00 00 00    	je     80101a00 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101959:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010195c:	8b 40 58             	mov    0x58(%eax),%eax
8010195f:	39 f0                	cmp    %esi,%eax
80101961:	0f 82 ba 00 00 00    	jb     80101a21 <readi+0xf1>
80101967:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010196a:	89 f9                	mov    %edi,%ecx
8010196c:	01 f1                	add    %esi,%ecx
8010196e:	0f 82 ad 00 00 00    	jb     80101a21 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101974:	89 c2                	mov    %eax,%edx
80101976:	29 f2                	sub    %esi,%edx
80101978:	39 c8                	cmp    %ecx,%eax
8010197a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010197d:	31 ff                	xor    %edi,%edi
8010197f:	85 d2                	test   %edx,%edx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101981:	89 55 e4             	mov    %edx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101984:	74 6c                	je     801019f2 <readi+0xc2>
80101986:	8d 76 00             	lea    0x0(%esi),%esi
80101989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101990:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101993:	89 f2                	mov    %esi,%edx
80101995:	c1 ea 09             	shr    $0x9,%edx
80101998:	89 d8                	mov    %ebx,%eax
8010199a:	e8 41 f9 ff ff       	call   801012e0 <bmap>
8010199f:	83 ec 08             	sub    $0x8,%esp
801019a2:	50                   	push   %eax
801019a3:	ff 33                	pushl  (%ebx)
801019a5:	e8 26 e7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019aa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ad:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019af:	89 f0                	mov    %esi,%eax
801019b1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019b6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019bb:	83 c4 0c             	add    $0xc,%esp
801019be:	29 c1                	sub    %eax,%ecx
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019c0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801019c4:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801019c7:	29 fb                	sub    %edi,%ebx
801019c9:	39 d9                	cmp    %ebx,%ecx
801019cb:	0f 46 d9             	cmovbe %ecx,%ebx
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019ce:	53                   	push   %ebx
801019cf:	50                   	push   %eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d0:	01 df                	add    %ebx,%edi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019d2:	ff 75 e0             	pushl  -0x20(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d5:	01 de                	add    %ebx,%esi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019d7:	e8 14 2d 00 00       	call   801046f0 <memmove>
    brelse(bp);
801019dc:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019df:	89 14 24             	mov    %edx,(%esp)
801019e2:	e8 f9 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019e7:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019ea:	83 c4 10             	add    $0x10,%esp
801019ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801019f0:	77 9e                	ja     80101990 <readi+0x60>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
801019f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
801019f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019f8:	5b                   	pop    %ebx
801019f9:	5e                   	pop    %esi
801019fa:	5f                   	pop    %edi
801019fb:	5d                   	pop    %ebp
801019fc:	c3                   	ret    
801019fd:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a00:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a04:	66 83 f8 09          	cmp    $0x9,%ax
80101a08:	77 17                	ja     80101a21 <readi+0xf1>
80101a0a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a11:	85 c0                	test   %eax,%eax
80101a13:	74 0c                	je     80101a21 <readi+0xf1>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a15:	89 7d 10             	mov    %edi,0x10(%ebp)
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a1b:	5b                   	pop    %ebx
80101a1c:	5e                   	pop    %esi
80101a1d:	5f                   	pop    %edi
80101a1e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a1f:	ff e0                	jmp    *%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a26:	eb cd                	jmp    801019f5 <readi+0xc5>
80101a28:	90                   	nop
80101a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a30 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a30:	55                   	push   %ebp
80101a31:	89 e5                	mov    %esp,%ebp
80101a33:	57                   	push   %edi
80101a34:	56                   	push   %esi
80101a35:	53                   	push   %ebx
80101a36:	83 ec 1c             	sub    $0x1c,%esp
80101a39:	8b 45 08             	mov    0x8(%ebp),%eax
80101a3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a3f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a42:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a47:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a4a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a4d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a50:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a53:	0f 84 b7 00 00 00    	je     80101b10 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a5c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a5f:	0f 82 eb 00 00 00    	jb     80101b50 <writei+0x120>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a65:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a68:	89 c8                	mov    %ecx,%eax
80101a6a:	01 f0                	add    %esi,%eax
80101a6c:	0f 82 de 00 00 00    	jb     80101b50 <writei+0x120>
80101a72:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a77:	0f 87 d3 00 00 00    	ja     80101b50 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a7d:	85 c9                	test   %ecx,%ecx
80101a7f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a86:	74 79                	je     80101b01 <writei+0xd1>
80101a88:	90                   	nop
80101a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a90:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101a93:	89 f2                	mov    %esi,%edx
80101a95:	c1 ea 09             	shr    $0x9,%edx
80101a98:	89 f8                	mov    %edi,%eax
80101a9a:	e8 41 f8 ff ff       	call   801012e0 <bmap>
80101a9f:	83 ec 08             	sub    $0x8,%esp
80101aa2:	50                   	push   %eax
80101aa3:	ff 37                	pushl  (%edi)
80101aa5:	e8 26 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aaa:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101aad:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ab0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ab2:	89 f0                	mov    %esi,%eax
80101ab4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ab9:	83 c4 0c             	add    $0xc,%esp
80101abc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ac1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ac3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101ac7:	39 d9                	cmp    %ebx,%ecx
80101ac9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101acc:	53                   	push   %ebx
80101acd:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ad0:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101ad2:	50                   	push   %eax
80101ad3:	e8 18 2c 00 00       	call   801046f0 <memmove>
    log_write(bp);
80101ad8:	89 3c 24             	mov    %edi,(%esp)
80101adb:	e8 70 12 00 00       	call   80102d50 <log_write>
    brelse(bp);
80101ae0:	89 3c 24             	mov    %edi,(%esp)
80101ae3:	e8 f8 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ae8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101aeb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101aee:	83 c4 10             	add    $0x10,%esp
80101af1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101af4:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101af7:	77 97                	ja     80101a90 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101af9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101afc:	3b 70 58             	cmp    0x58(%eax),%esi
80101aff:	77 37                	ja     80101b38 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b01:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b04:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b07:	5b                   	pop    %ebx
80101b08:	5e                   	pop    %esi
80101b09:	5f                   	pop    %edi
80101b0a:	5d                   	pop    %ebp
80101b0b:	c3                   	ret    
80101b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b14:	66 83 f8 09          	cmp    $0x9,%ax
80101b18:	77 36                	ja     80101b50 <writei+0x120>
80101b1a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b21:	85 c0                	test   %eax,%eax
80101b23:	74 2b                	je     80101b50 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b25:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b2b:	5b                   	pop    %ebx
80101b2c:	5e                   	pop    %esi
80101b2d:	5f                   	pop    %edi
80101b2e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b2f:	ff e0                	jmp    *%eax
80101b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b38:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b3b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b3e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b41:	50                   	push   %eax
80101b42:	e8 79 fa ff ff       	call   801015c0 <iupdate>
80101b47:	83 c4 10             	add    $0x10,%esp
80101b4a:	eb b5                	jmp    80101b01 <writei+0xd1>
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b55:	eb ad                	jmp    80101b04 <writei+0xd4>
80101b57:	89 f6                	mov    %esi,%esi
80101b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b60 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b60:	55                   	push   %ebp
80101b61:	89 e5                	mov    %esp,%ebp
80101b63:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b66:	6a 0e                	push   $0xe
80101b68:	ff 75 0c             	pushl  0xc(%ebp)
80101b6b:	ff 75 08             	pushl  0x8(%ebp)
80101b6e:	e8 ed 2b 00 00       	call   80104760 <strncmp>
}
80101b73:	c9                   	leave  
80101b74:	c3                   	ret    
80101b75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b80 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	57                   	push   %edi
80101b84:	56                   	push   %esi
80101b85:	53                   	push   %ebx
80101b86:	83 ec 1c             	sub    $0x1c,%esp
80101b89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b8c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101b91:	0f 85 80 00 00 00    	jne    80101c17 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101b97:	8b 53 58             	mov    0x58(%ebx),%edx
80101b9a:	31 ff                	xor    %edi,%edi
80101b9c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101b9f:	85 d2                	test   %edx,%edx
80101ba1:	75 0d                	jne    80101bb0 <dirlookup+0x30>
80101ba3:	eb 5b                	jmp    80101c00 <dirlookup+0x80>
80101ba5:	8d 76 00             	lea    0x0(%esi),%esi
80101ba8:	83 c7 10             	add    $0x10,%edi
80101bab:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bae:	76 50                	jbe    80101c00 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bb0:	6a 10                	push   $0x10
80101bb2:	57                   	push   %edi
80101bb3:	56                   	push   %esi
80101bb4:	53                   	push   %ebx
80101bb5:	e8 76 fd ff ff       	call   80101930 <readi>
80101bba:	83 c4 10             	add    $0x10,%esp
80101bbd:	83 f8 10             	cmp    $0x10,%eax
80101bc0:	75 48                	jne    80101c0a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80101bc2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bc7:	74 df                	je     80101ba8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101bc9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bcc:	83 ec 04             	sub    $0x4,%esp
80101bcf:	6a 0e                	push   $0xe
80101bd1:	50                   	push   %eax
80101bd2:	ff 75 0c             	pushl  0xc(%ebp)
80101bd5:	e8 86 2b 00 00       	call   80104760 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101bda:	83 c4 10             	add    $0x10,%esp
80101bdd:	85 c0                	test   %eax,%eax
80101bdf:	75 c7                	jne    80101ba8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101be1:	8b 45 10             	mov    0x10(%ebp),%eax
80101be4:	85 c0                	test   %eax,%eax
80101be6:	74 05                	je     80101bed <dirlookup+0x6d>
        *poff = off;
80101be8:	8b 45 10             	mov    0x10(%ebp),%eax
80101beb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101bed:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101bf1:	8b 03                	mov    (%ebx),%eax
80101bf3:	e8 18 f6 ff ff       	call   80101210 <iget>
    }
  }

  return 0;
}
80101bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bfb:	5b                   	pop    %ebx
80101bfc:	5e                   	pop    %esi
80101bfd:	5f                   	pop    %edi
80101bfe:	5d                   	pop    %ebp
80101bff:	c3                   	ret    
80101c00:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c03:	31 c0                	xor    %eax,%eax
}
80101c05:	5b                   	pop    %ebx
80101c06:	5e                   	pop    %esi
80101c07:	5f                   	pop    %edi
80101c08:	5d                   	pop    %ebp
80101c09:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101c0a:	83 ec 0c             	sub    $0xc,%esp
80101c0d:	68 59 73 10 80       	push   $0x80107359
80101c12:	e8 59 e7 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c17:	83 ec 0c             	sub    $0xc,%esp
80101c1a:	68 47 73 10 80       	push   $0x80107347
80101c1f:	e8 4c e7 ff ff       	call   80100370 <panic>
80101c24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c30 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c30:	55                   	push   %ebp
80101c31:	89 e5                	mov    %esp,%ebp
80101c33:	57                   	push   %edi
80101c34:	56                   	push   %esi
80101c35:	53                   	push   %ebx
80101c36:	89 cf                	mov    %ecx,%edi
80101c38:	89 c3                	mov    %eax,%ebx
80101c3a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c3d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c40:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101c43:	0f 84 55 01 00 00    	je     80101d9e <namex+0x16e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c49:	e8 82 1c 00 00       	call   801038d0 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c4e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c51:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c54:	68 e0 09 11 80       	push   $0x801109e0
80101c59:	e8 72 28 00 00       	call   801044d0 <acquire>
  ip->ref++;
80101c5e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c62:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101c69:	e8 82 29 00 00       	call   801045f0 <release>
80101c6e:	83 c4 10             	add    $0x10,%esp
80101c71:	eb 08                	jmp    80101c7b <namex+0x4b>
80101c73:	90                   	nop
80101c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101c78:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101c7b:	0f b6 03             	movzbl (%ebx),%eax
80101c7e:	3c 2f                	cmp    $0x2f,%al
80101c80:	74 f6                	je     80101c78 <namex+0x48>
    path++;
  if(*path == 0)
80101c82:	84 c0                	test   %al,%al
80101c84:	0f 84 e3 00 00 00    	je     80101d6d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c8a:	0f b6 03             	movzbl (%ebx),%eax
80101c8d:	89 da                	mov    %ebx,%edx
80101c8f:	84 c0                	test   %al,%al
80101c91:	0f 84 ac 00 00 00    	je     80101d43 <namex+0x113>
80101c97:	3c 2f                	cmp    $0x2f,%al
80101c99:	75 09                	jne    80101ca4 <namex+0x74>
80101c9b:	e9 a3 00 00 00       	jmp    80101d43 <namex+0x113>
80101ca0:	84 c0                	test   %al,%al
80101ca2:	74 0a                	je     80101cae <namex+0x7e>
    path++;
80101ca4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101ca7:	0f b6 02             	movzbl (%edx),%eax
80101caa:	3c 2f                	cmp    $0x2f,%al
80101cac:	75 f2                	jne    80101ca0 <namex+0x70>
80101cae:	89 d1                	mov    %edx,%ecx
80101cb0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101cb2:	83 f9 0d             	cmp    $0xd,%ecx
80101cb5:	0f 8e 8d 00 00 00    	jle    80101d48 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101cbb:	83 ec 04             	sub    $0x4,%esp
80101cbe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cc1:	6a 0e                	push   $0xe
80101cc3:	53                   	push   %ebx
80101cc4:	57                   	push   %edi
80101cc5:	e8 26 2a 00 00       	call   801046f0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101ccd:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cd0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cd2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101cd5:	75 11                	jne    80101ce8 <namex+0xb8>
80101cd7:	89 f6                	mov    %esi,%esi
80101cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101ce0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101ce3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101ce6:	74 f8                	je     80101ce0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101ce8:	83 ec 0c             	sub    $0xc,%esp
80101ceb:	56                   	push   %esi
80101cec:	e8 7f f9 ff ff       	call   80101670 <ilock>
    if(ip->type != T_DIR){
80101cf1:	83 c4 10             	add    $0x10,%esp
80101cf4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101cf9:	0f 85 7f 00 00 00    	jne    80101d7e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101cff:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d02:	85 d2                	test   %edx,%edx
80101d04:	74 09                	je     80101d0f <namex+0xdf>
80101d06:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d09:	0f 84 a5 00 00 00    	je     80101db4 <namex+0x184>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d0f:	83 ec 04             	sub    $0x4,%esp
80101d12:	6a 00                	push   $0x0
80101d14:	57                   	push   %edi
80101d15:	56                   	push   %esi
80101d16:	e8 65 fe ff ff       	call   80101b80 <dirlookup>
80101d1b:	83 c4 10             	add    $0x10,%esp
80101d1e:	85 c0                	test   %eax,%eax
80101d20:	74 5c                	je     80101d7e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d22:	83 ec 0c             	sub    $0xc,%esp
80101d25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d28:	56                   	push   %esi
80101d29:	e8 22 fa ff ff       	call   80101750 <iunlock>
  iput(ip);
80101d2e:	89 34 24             	mov    %esi,(%esp)
80101d31:	e8 6a fa ff ff       	call   801017a0 <iput>
80101d36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d39:	83 c4 10             	add    $0x10,%esp
80101d3c:	89 c6                	mov    %eax,%esi
80101d3e:	e9 38 ff ff ff       	jmp    80101c7b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d43:	31 c9                	xor    %ecx,%ecx
80101d45:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101d48:	83 ec 04             	sub    $0x4,%esp
80101d4b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d4e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d51:	51                   	push   %ecx
80101d52:	53                   	push   %ebx
80101d53:	57                   	push   %edi
80101d54:	e8 97 29 00 00       	call   801046f0 <memmove>
    name[len] = 0;
80101d59:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d5c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d5f:	83 c4 10             	add    $0x10,%esp
80101d62:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d66:	89 d3                	mov    %edx,%ebx
80101d68:	e9 65 ff ff ff       	jmp    80101cd2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d70:	85 c0                	test   %eax,%eax
80101d72:	75 56                	jne    80101dca <namex+0x19a>
    iput(ip);
    return 0;
  }
  return ip;
}
80101d74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d77:	89 f0                	mov    %esi,%eax
80101d79:	5b                   	pop    %ebx
80101d7a:	5e                   	pop    %esi
80101d7b:	5f                   	pop    %edi
80101d7c:	5d                   	pop    %ebp
80101d7d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d7e:	83 ec 0c             	sub    $0xc,%esp
80101d81:	56                   	push   %esi
80101d82:	e8 c9 f9 ff ff       	call   80101750 <iunlock>
  iput(ip);
80101d87:	89 34 24             	mov    %esi,(%esp)
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d8a:	31 f6                	xor    %esi,%esi
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
80101d8c:	e8 0f fa ff ff       	call   801017a0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d91:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d94:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d97:	89 f0                	mov    %esi,%eax
80101d99:	5b                   	pop    %ebx
80101d9a:	5e                   	pop    %esi
80101d9b:	5f                   	pop    %edi
80101d9c:	5d                   	pop    %ebp
80101d9d:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101d9e:	ba 01 00 00 00       	mov    $0x1,%edx
80101da3:	b8 01 00 00 00       	mov    $0x1,%eax
80101da8:	e8 63 f4 ff ff       	call   80101210 <iget>
80101dad:	89 c6                	mov    %eax,%esi
80101daf:	e9 c7 fe ff ff       	jmp    80101c7b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101db4:	83 ec 0c             	sub    $0xc,%esp
80101db7:	56                   	push   %esi
80101db8:	e8 93 f9 ff ff       	call   80101750 <iunlock>
      return ip;
80101dbd:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dc3:	89 f0                	mov    %esi,%eax
80101dc5:	5b                   	pop    %ebx
80101dc6:	5e                   	pop    %esi
80101dc7:	5f                   	pop    %edi
80101dc8:	5d                   	pop    %ebp
80101dc9:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101dca:	83 ec 0c             	sub    $0xc,%esp
80101dcd:	56                   	push   %esi
    return 0;
80101dce:	31 f6                	xor    %esi,%esi
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101dd0:	e8 cb f9 ff ff       	call   801017a0 <iput>
    return 0;
80101dd5:	83 c4 10             	add    $0x10,%esp
80101dd8:	eb 9a                	jmp    80101d74 <namex+0x144>
80101dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101de0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101de0:	55                   	push   %ebp
80101de1:	89 e5                	mov    %esp,%ebp
80101de3:	57                   	push   %edi
80101de4:	56                   	push   %esi
80101de5:	53                   	push   %ebx
80101de6:	83 ec 20             	sub    $0x20,%esp
80101de9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101dec:	6a 00                	push   $0x0
80101dee:	ff 75 0c             	pushl  0xc(%ebp)
80101df1:	53                   	push   %ebx
80101df2:	e8 89 fd ff ff       	call   80101b80 <dirlookup>
80101df7:	83 c4 10             	add    $0x10,%esp
80101dfa:	85 c0                	test   %eax,%eax
80101dfc:	75 67                	jne    80101e65 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101dfe:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e01:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e04:	85 ff                	test   %edi,%edi
80101e06:	74 29                	je     80101e31 <dirlink+0x51>
80101e08:	31 ff                	xor    %edi,%edi
80101e0a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e0d:	eb 09                	jmp    80101e18 <dirlink+0x38>
80101e0f:	90                   	nop
80101e10:	83 c7 10             	add    $0x10,%edi
80101e13:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e16:	76 19                	jbe    80101e31 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e18:	6a 10                	push   $0x10
80101e1a:	57                   	push   %edi
80101e1b:	56                   	push   %esi
80101e1c:	53                   	push   %ebx
80101e1d:	e8 0e fb ff ff       	call   80101930 <readi>
80101e22:	83 c4 10             	add    $0x10,%esp
80101e25:	83 f8 10             	cmp    $0x10,%eax
80101e28:	75 4e                	jne    80101e78 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e2f:	75 df                	jne    80101e10 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e31:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e34:	83 ec 04             	sub    $0x4,%esp
80101e37:	6a 0e                	push   $0xe
80101e39:	ff 75 0c             	pushl  0xc(%ebp)
80101e3c:	50                   	push   %eax
80101e3d:	e8 7e 29 00 00       	call   801047c0 <strncpy>
  de.inum = inum;
80101e42:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e45:	6a 10                	push   $0x10
80101e47:	57                   	push   %edi
80101e48:	56                   	push   %esi
80101e49:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101e4a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e4e:	e8 dd fb ff ff       	call   80101a30 <writei>
80101e53:	83 c4 20             	add    $0x20,%esp
80101e56:	83 f8 10             	cmp    $0x10,%eax
80101e59:	75 2a                	jne    80101e85 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e5b:	31 c0                	xor    %eax,%eax
}
80101e5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e60:	5b                   	pop    %ebx
80101e61:	5e                   	pop    %esi
80101e62:	5f                   	pop    %edi
80101e63:	5d                   	pop    %ebp
80101e64:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101e65:	83 ec 0c             	sub    $0xc,%esp
80101e68:	50                   	push   %eax
80101e69:	e8 32 f9 ff ff       	call   801017a0 <iput>
    return -1;
80101e6e:	83 c4 10             	add    $0x10,%esp
80101e71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e76:	eb e5                	jmp    80101e5d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101e78:	83 ec 0c             	sub    $0xc,%esp
80101e7b:	68 68 73 10 80       	push   $0x80107368
80101e80:	e8 eb e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	68 8e 79 10 80       	push   $0x8010798e
80101e8d:	e8 de e4 ff ff       	call   80100370 <panic>
80101e92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ea0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101ea0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ea1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101ea3:	89 e5                	mov    %esp,%ebp
80101ea5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ea8:	8b 45 08             	mov    0x8(%ebp),%eax
80101eab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101eae:	e8 7d fd ff ff       	call   80101c30 <namex>
}
80101eb3:	c9                   	leave  
80101eb4:	c3                   	ret    
80101eb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ec0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101ec0:	55                   	push   %ebp
  return namex(path, 1, name);
80101ec1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101ec6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101ec8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ecb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ece:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101ecf:	e9 5c fd ff ff       	jmp    80101c30 <namex>
80101ed4:	66 90                	xchg   %ax,%ax
80101ed6:	66 90                	xchg   %ax,%ax
80101ed8:	66 90                	xchg   %ax,%ax
80101eda:	66 90                	xchg   %ax,%ax
80101edc:	66 90                	xchg   %ax,%ax
80101ede:	66 90                	xchg   %ax,%ax

80101ee0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ee0:	55                   	push   %ebp
  if(b == 0)
80101ee1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ee3:	89 e5                	mov    %esp,%ebp
80101ee5:	56                   	push   %esi
80101ee6:	53                   	push   %ebx
  if(b == 0)
80101ee7:	0f 84 ad 00 00 00    	je     80101f9a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101eed:	8b 58 08             	mov    0x8(%eax),%ebx
80101ef0:	89 c1                	mov    %eax,%ecx
80101ef2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101ef8:	0f 87 8f 00 00 00    	ja     80101f8d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101efe:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f03:	90                   	nop
80101f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f08:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f09:	83 e0 c0             	and    $0xffffffc0,%eax
80101f0c:	3c 40                	cmp    $0x40,%al
80101f0e:	75 f8                	jne    80101f08 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f10:	31 f6                	xor    %esi,%esi
80101f12:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f17:	89 f0                	mov    %esi,%eax
80101f19:	ee                   	out    %al,(%dx)
80101f1a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f1f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f24:	ee                   	out    %al,(%dx)
80101f25:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f2a:	89 d8                	mov    %ebx,%eax
80101f2c:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f2d:	89 d8                	mov    %ebx,%eax
80101f2f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f34:	c1 f8 08             	sar    $0x8,%eax
80101f37:	ee                   	out    %al,(%dx)
80101f38:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f3d:	89 f0                	mov    %esi,%eax
80101f3f:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f40:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f44:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f49:	c1 e0 04             	shl    $0x4,%eax
80101f4c:	83 e0 10             	and    $0x10,%eax
80101f4f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f52:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101f53:	f6 01 04             	testb  $0x4,(%ecx)
80101f56:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f5b:	75 13                	jne    80101f70 <idestart+0x90>
80101f5d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f62:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f63:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f66:	5b                   	pop    %ebx
80101f67:	5e                   	pop    %esi
80101f68:	5d                   	pop    %ebp
80101f69:	c3                   	ret    
80101f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f70:	b8 30 00 00 00       	mov    $0x30,%eax
80101f75:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101f76:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101f7b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f7e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101f83:	fc                   	cld    
80101f84:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f86:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f89:	5b                   	pop    %ebx
80101f8a:	5e                   	pop    %esi
80101f8b:	5d                   	pop    %ebp
80101f8c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101f8d:	83 ec 0c             	sub    $0xc,%esp
80101f90:	68 d4 73 10 80       	push   $0x801073d4
80101f95:	e8 d6 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101f9a:	83 ec 0c             	sub    $0xc,%esp
80101f9d:	68 cb 73 10 80       	push   $0x801073cb
80101fa2:	e8 c9 e3 ff ff       	call   80100370 <panic>
80101fa7:	89 f6                	mov    %esi,%esi
80101fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fb0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101fb0:	55                   	push   %ebp
80101fb1:	89 e5                	mov    %esp,%ebp
80101fb3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101fb6:	68 e6 73 10 80       	push   $0x801073e6
80101fbb:	68 80 a5 10 80       	push   $0x8010a580
80101fc0:	e8 0b 24 00 00       	call   801043d0 <initlock>
  picenable(IRQ_IDE);
80101fc5:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80101fcc:	e8 3f 12 00 00       	call   80103210 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fd1:	58                   	pop    %eax
80101fd2:	a1 00 2d 11 80       	mov    0x80112d00,%eax
80101fd7:	5a                   	pop    %edx
80101fd8:	83 e8 01             	sub    $0x1,%eax
80101fdb:	50                   	push   %eax
80101fdc:	6a 0e                	push   $0xe
80101fde:	e8 bd 02 00 00       	call   801022a0 <ioapicenable>
80101fe3:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fe6:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101feb:	90                   	nop
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ff0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ff1:	83 e0 c0             	and    $0xffffffc0,%eax
80101ff4:	3c 40                	cmp    $0x40,%al
80101ff6:	75 f8                	jne    80101ff0 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101ff8:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101ffd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102002:	ee                   	out    %al,(%dx)
80102003:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102008:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010200d:	eb 06                	jmp    80102015 <ideinit+0x65>
8010200f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102010:	83 e9 01             	sub    $0x1,%ecx
80102013:	74 0f                	je     80102024 <ideinit+0x74>
80102015:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102016:	84 c0                	test   %al,%al
80102018:	74 f6                	je     80102010 <ideinit+0x60>
      havedisk1 = 1;
8010201a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102021:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102024:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102029:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010202e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010202f:	c9                   	leave  
80102030:	c3                   	ret    
80102031:	eb 0d                	jmp    80102040 <ideintr>
80102033:	90                   	nop
80102034:	90                   	nop
80102035:	90                   	nop
80102036:	90                   	nop
80102037:	90                   	nop
80102038:	90                   	nop
80102039:	90                   	nop
8010203a:	90                   	nop
8010203b:	90                   	nop
8010203c:	90                   	nop
8010203d:	90                   	nop
8010203e:	90                   	nop
8010203f:	90                   	nop

80102040 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102040:	55                   	push   %ebp
80102041:	89 e5                	mov    %esp,%ebp
80102043:	57                   	push   %edi
80102044:	56                   	push   %esi
80102045:	53                   	push   %ebx
80102046:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102049:	68 80 a5 10 80       	push   $0x8010a580
8010204e:	e8 7d 24 00 00       	call   801044d0 <acquire>

  if((b = idequeue) == 0){
80102053:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102059:	83 c4 10             	add    $0x10,%esp
8010205c:	85 db                	test   %ebx,%ebx
8010205e:	74 34                	je     80102094 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102060:	8b 43 58             	mov    0x58(%ebx),%eax
80102063:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102068:	8b 33                	mov    (%ebx),%esi
8010206a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102070:	74 3e                	je     801020b0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102072:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102075:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102078:	83 ce 02             	or     $0x2,%esi
8010207b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010207d:	53                   	push   %ebx
8010207e:	e8 bd 1f 00 00       	call   80104040 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102083:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102088:	83 c4 10             	add    $0x10,%esp
8010208b:	85 c0                	test   %eax,%eax
8010208d:	74 05                	je     80102094 <ideintr+0x54>
    idestart(idequeue);
8010208f:	e8 4c fe ff ff       	call   80101ee0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102094:	83 ec 0c             	sub    $0xc,%esp
80102097:	68 80 a5 10 80       	push   $0x8010a580
8010209c:	e8 4f 25 00 00       	call   801045f0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801020a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020a4:	5b                   	pop    %ebx
801020a5:	5e                   	pop    %esi
801020a6:	5f                   	pop    %edi
801020a7:	5d                   	pop    %ebp
801020a8:	c3                   	ret    
801020a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020b0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020b5:	8d 76 00             	lea    0x0(%esi),%esi
801020b8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020b9:	89 c1                	mov    %eax,%ecx
801020bb:	83 e1 c0             	and    $0xffffffc0,%ecx
801020be:	80 f9 40             	cmp    $0x40,%cl
801020c1:	75 f5                	jne    801020b8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020c3:	a8 21                	test   $0x21,%al
801020c5:	75 ab                	jne    80102072 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801020c7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801020ca:	b9 80 00 00 00       	mov    $0x80,%ecx
801020cf:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020d4:	fc                   	cld    
801020d5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020d7:	8b 33                	mov    (%ebx),%esi
801020d9:	eb 97                	jmp    80102072 <ideintr+0x32>
801020db:	90                   	nop
801020dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	53                   	push   %ebx
801020e4:	83 ec 10             	sub    $0x10,%esp
801020e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801020ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801020ed:	50                   	push   %eax
801020ee:	e8 ad 22 00 00       	call   801043a0 <holdingsleep>
801020f3:	83 c4 10             	add    $0x10,%esp
801020f6:	85 c0                	test   %eax,%eax
801020f8:	0f 84 ad 00 00 00    	je     801021ab <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801020fe:	8b 03                	mov    (%ebx),%eax
80102100:	83 e0 06             	and    $0x6,%eax
80102103:	83 f8 02             	cmp    $0x2,%eax
80102106:	0f 84 b9 00 00 00    	je     801021c5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010210c:	8b 53 04             	mov    0x4(%ebx),%edx
8010210f:	85 d2                	test   %edx,%edx
80102111:	74 0d                	je     80102120 <iderw+0x40>
80102113:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102118:	85 c0                	test   %eax,%eax
8010211a:	0f 84 98 00 00 00    	je     801021b8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102120:	83 ec 0c             	sub    $0xc,%esp
80102123:	68 80 a5 10 80       	push   $0x8010a580
80102128:	e8 a3 23 00 00       	call   801044d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010212d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102133:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102136:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010213d:	85 d2                	test   %edx,%edx
8010213f:	75 09                	jne    8010214a <iderw+0x6a>
80102141:	eb 58                	jmp    8010219b <iderw+0xbb>
80102143:	90                   	nop
80102144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102148:	89 c2                	mov    %eax,%edx
8010214a:	8b 42 58             	mov    0x58(%edx),%eax
8010214d:	85 c0                	test   %eax,%eax
8010214f:	75 f7                	jne    80102148 <iderw+0x68>
80102151:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102154:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102156:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010215c:	74 44                	je     801021a2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	74 23                	je     8010218b <iderw+0xab>
80102168:	90                   	nop
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102170:	83 ec 08             	sub    $0x8,%esp
80102173:	68 80 a5 10 80       	push   $0x8010a580
80102178:	53                   	push   %ebx
80102179:	e8 02 1d 00 00       	call   80103e80 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010217e:	8b 03                	mov    (%ebx),%eax
80102180:	83 c4 10             	add    $0x10,%esp
80102183:	83 e0 06             	and    $0x6,%eax
80102186:	83 f8 02             	cmp    $0x2,%eax
80102189:	75 e5                	jne    80102170 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
8010218b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102192:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102195:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102196:	e9 55 24 00 00       	jmp    801045f0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801021a0:	eb b2                	jmp    80102154 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801021a2:	89 d8                	mov    %ebx,%eax
801021a4:	e8 37 fd ff ff       	call   80101ee0 <idestart>
801021a9:	eb b3                	jmp    8010215e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801021ab:	83 ec 0c             	sub    $0xc,%esp
801021ae:	68 ea 73 10 80       	push   $0x801073ea
801021b3:	e8 b8 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801021b8:	83 ec 0c             	sub    $0xc,%esp
801021bb:	68 15 74 10 80       	push   $0x80107415
801021c0:	e8 ab e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021c5:	83 ec 0c             	sub    $0xc,%esp
801021c8:	68 00 74 10 80       	push   $0x80107400
801021cd:	e8 9e e1 ff ff       	call   80100370 <panic>
801021d2:	66 90                	xchg   %ax,%ax
801021d4:	66 90                	xchg   %ax,%ax
801021d6:	66 90                	xchg   %ax,%ax
801021d8:	66 90                	xchg   %ax,%ax
801021da:	66 90                	xchg   %ax,%ax
801021dc:	66 90                	xchg   %ax,%ax
801021de:	66 90                	xchg   %ax,%ax

801021e0 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
801021e0:	a1 64 27 11 80       	mov    0x80112764,%eax
801021e5:	85 c0                	test   %eax,%eax
801021e7:	0f 84 a8 00 00 00    	je     80102295 <ioapicinit+0xb5>
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021ed:	55                   	push   %ebp
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801021ee:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801021f5:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021f8:	89 e5                	mov    %esp,%ebp
801021fa:	56                   	push   %esi
801021fb:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021fc:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102203:	00 00 00 
  return ioapic->data;
80102206:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010220c:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010220f:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102215:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010221b:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102222:	c1 ee 10             	shr    $0x10,%esi
80102225:	89 f0                	mov    %esi,%eax
80102227:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010222a:	8b 41 10             	mov    0x10(%ecx),%eax
  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
8010222d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102230:	39 d0                	cmp    %edx,%eax
80102232:	74 16                	je     8010224a <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102234:	83 ec 0c             	sub    $0xc,%esp
80102237:	68 34 74 10 80       	push   $0x80107434
8010223c:	e8 1f e4 ff ff       	call   80100660 <cprintf>
80102241:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102247:	83 c4 10             	add    $0x10,%esp
8010224a:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010224d:	ba 10 00 00 00       	mov    $0x10,%edx
80102252:	b8 20 00 00 00       	mov    $0x20,%eax
80102257:	89 f6                	mov    %esi,%esi
80102259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102260:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102262:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102268:	89 c3                	mov    %eax,%ebx
8010226a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102270:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102273:	89 59 10             	mov    %ebx,0x10(%ecx)
80102276:	8d 5a 01             	lea    0x1(%edx),%ebx
80102279:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010227c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010227e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102280:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102286:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010228d:	75 d1                	jne    80102260 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010228f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102292:	5b                   	pop    %ebx
80102293:	5e                   	pop    %esi
80102294:	5d                   	pop    %ebp
80102295:	f3 c3                	repz ret 
80102297:	89 f6                	mov    %esi,%esi
80102299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
801022a0:	8b 15 64 27 11 80    	mov    0x80112764,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801022a6:	55                   	push   %ebp
801022a7:	89 e5                	mov    %esp,%ebp
  if(!ismp)
801022a9:	85 d2                	test   %edx,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801022ab:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
801022ae:	74 2b                	je     801022db <ioapicenable+0x3b>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022b0:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022b6:	8d 50 20             	lea    0x20(%eax),%edx
801022b9:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022bd:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022bf:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022c5:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022c8:	89 51 10             	mov    %edx,0x10(%ecx)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022cb:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022ce:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022d0:	a1 34 26 11 80       	mov    0x80112634,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022d5:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022d8:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022db:	5d                   	pop    %ebp
801022dc:	c3                   	ret    
801022dd:	66 90                	xchg   %ax,%ax
801022df:	90                   	nop

801022e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 04             	sub    $0x4,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022ea:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022f0:	75 70                	jne    80102362 <kfree+0x82>
801022f2:	81 fb a8 5c 11 80    	cmp    $0x80115ca8,%ebx
801022f8:	72 68                	jb     80102362 <kfree+0x82>
801022fa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102300:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102305:	77 5b                	ja     80102362 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102307:	83 ec 04             	sub    $0x4,%esp
8010230a:	68 00 10 00 00       	push   $0x1000
8010230f:	6a 01                	push   $0x1
80102311:	53                   	push   %ebx
80102312:	e8 29 23 00 00       	call   80104640 <memset>

  if(kmem.use_lock)
80102317:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010231d:	83 c4 10             	add    $0x10,%esp
80102320:	85 d2                	test   %edx,%edx
80102322:	75 2c                	jne    80102350 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102324:	a1 78 26 11 80       	mov    0x80112678,%eax
80102329:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010232b:	a1 74 26 11 80       	mov    0x80112674,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102330:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102336:	85 c0                	test   %eax,%eax
80102338:	75 06                	jne    80102340 <kfree+0x60>
    release(&kmem.lock);
}
8010233a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010233d:	c9                   	leave  
8010233e:	c3                   	ret    
8010233f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102340:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102347:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010234a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010234b:	e9 a0 22 00 00       	jmp    801045f0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102350:	83 ec 0c             	sub    $0xc,%esp
80102353:	68 40 26 11 80       	push   $0x80112640
80102358:	e8 73 21 00 00       	call   801044d0 <acquire>
8010235d:	83 c4 10             	add    $0x10,%esp
80102360:	eb c2                	jmp    80102324 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102362:	83 ec 0c             	sub    $0xc,%esp
80102365:	68 66 74 10 80       	push   $0x80107466
8010236a:	e8 01 e0 ff ff       	call   80100370 <panic>
8010236f:	90                   	nop

80102370 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	56                   	push   %esi
80102374:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102375:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102378:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010237b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102381:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102387:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010238d:	39 de                	cmp    %ebx,%esi
8010238f:	72 23                	jb     801023b4 <freerange+0x44>
80102391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102398:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010239e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023a7:	50                   	push   %eax
801023a8:	e8 33 ff ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	39 f3                	cmp    %esi,%ebx
801023b2:	76 e4                	jbe    80102398 <freerange+0x28>
    kfree(p);
}
801023b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023b7:	5b                   	pop    %ebx
801023b8:	5e                   	pop    %esi
801023b9:	5d                   	pop    %ebp
801023ba:	c3                   	ret    
801023bb:	90                   	nop
801023bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023c0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
801023c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023c8:	83 ec 08             	sub    $0x8,%esp
801023cb:	68 6c 74 10 80       	push   $0x8010746c
801023d0:	68 40 26 11 80       	push   $0x80112640
801023d5:	e8 f6 1f 00 00       	call   801043d0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023dd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801023e0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801023e7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023fc:	39 de                	cmp    %ebx,%esi
801023fe:	72 1c                	jb     8010241c <kinit1+0x5c>
    kfree(p);
80102400:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102406:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102409:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010240f:	50                   	push   %eax
80102410:	e8 cb fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102415:	83 c4 10             	add    $0x10,%esp
80102418:	39 de                	cmp    %ebx,%esi
8010241a:	73 e4                	jae    80102400 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010241c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010241f:	5b                   	pop    %ebx
80102420:	5e                   	pop    %esi
80102421:	5d                   	pop    %ebp
80102422:	c3                   	ret    
80102423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102430 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	56                   	push   %esi
80102434:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102435:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102438:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010243b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102441:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102447:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244d:	39 de                	cmp    %ebx,%esi
8010244f:	72 23                	jb     80102474 <kinit2+0x44>
80102451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102458:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010245e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102461:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102467:	50                   	push   %eax
80102468:	e8 73 fe ff ff       	call   801022e0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010246d:	83 c4 10             	add    $0x10,%esp
80102470:	39 de                	cmp    %ebx,%esi
80102472:	73 e4                	jae    80102458 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102474:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010247b:	00 00 00 
}
8010247e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102481:	5b                   	pop    %ebx
80102482:	5e                   	pop    %esi
80102483:	5d                   	pop    %ebp
80102484:	c3                   	ret    
80102485:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	53                   	push   %ebx
80102494:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102497:	a1 74 26 11 80       	mov    0x80112674,%eax
8010249c:	85 c0                	test   %eax,%eax
8010249e:	75 30                	jne    801024d0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024a0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024a6:	85 db                	test   %ebx,%ebx
801024a8:	74 1c                	je     801024c6 <kalloc+0x36>
    kmem.freelist = r->next;
801024aa:	8b 13                	mov    (%ebx),%edx
801024ac:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801024b2:	85 c0                	test   %eax,%eax
801024b4:	74 10                	je     801024c6 <kalloc+0x36>
    release(&kmem.lock);
801024b6:	83 ec 0c             	sub    $0xc,%esp
801024b9:	68 40 26 11 80       	push   $0x80112640
801024be:	e8 2d 21 00 00       	call   801045f0 <release>
801024c3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024c6:	89 d8                	mov    %ebx,%eax
801024c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024cb:	c9                   	leave  
801024cc:	c3                   	ret    
801024cd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 40 26 11 80       	push   $0x80112640
801024d8:	e8 f3 1f 00 00       	call   801044d0 <acquire>
  r = kmem.freelist;
801024dd:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024e3:	83 c4 10             	add    $0x10,%esp
801024e6:	a1 74 26 11 80       	mov    0x80112674,%eax
801024eb:	85 db                	test   %ebx,%ebx
801024ed:	75 bb                	jne    801024aa <kalloc+0x1a>
801024ef:	eb c1                	jmp    801024b2 <kalloc+0x22>
801024f1:	66 90                	xchg   %ax,%ax
801024f3:	66 90                	xchg   %ax,%ax
801024f5:	66 90                	xchg   %ax,%ax
801024f7:	66 90                	xchg   %ax,%ax
801024f9:	66 90                	xchg   %ax,%ax
801024fb:	66 90                	xchg   %ax,%ax
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <kbdgetc>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102500:	ba 64 00 00 00       	mov    $0x64,%edx
80102505:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102506:	a8 01                	test   $0x1,%al
80102508:	0f 84 c2 00 00 00    	je     801025d0 <kbdgetc+0xd0>
8010250e:	ba 60 00 00 00       	mov    $0x60,%edx
80102513:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102514:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102517:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
8010251d:	0f 84 9d 00 00 00    	je     801025c0 <kbdgetc+0xc0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102523:	84 c0                	test   %al,%al
80102525:	78 59                	js     80102580 <kbdgetc+0x80>
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102527:	55                   	push   %ebp
80102528:	89 e5                	mov    %esp,%ebp
8010252a:	53                   	push   %ebx
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010252b:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
80102531:	f6 c3 40             	test   $0x40,%bl
80102534:	74 09                	je     8010253f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102536:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102539:	83 e3 bf             	and    $0xffffffbf,%ebx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010253c:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
8010253f:	0f b6 8a a0 75 10 80 	movzbl -0x7fef8a60(%edx),%ecx
  shift ^= togglecode[data];
80102546:	0f b6 82 a0 74 10 80 	movzbl -0x7fef8b60(%edx),%eax
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
8010254d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010254f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102551:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102553:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102559:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010255c:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010255f:	8b 04 85 80 74 10 80 	mov    -0x7fef8b80(,%eax,4),%eax
80102566:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010256a:	74 0b                	je     80102577 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010256c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010256f:	83 fa 19             	cmp    $0x19,%edx
80102572:	77 3c                	ja     801025b0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102574:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102577:	5b                   	pop    %ebx
80102578:	5d                   	pop    %ebp
80102579:	c3                   	ret    
8010257a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102580:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
80102586:	83 e0 7f             	and    $0x7f,%eax
80102589:	f6 c1 40             	test   $0x40,%cl
8010258c:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
8010258f:	0f b6 82 a0 75 10 80 	movzbl -0x7fef8a60(%edx),%eax
80102596:	83 c8 40             	or     $0x40,%eax
80102599:	0f b6 c0             	movzbl %al,%eax
8010259c:	f7 d0                	not    %eax
8010259e:	21 c8                	and    %ecx,%eax
801025a0:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
801025a5:	31 c0                	xor    %eax,%eax
801025a7:	c3                   	ret    
801025a8:	90                   	nop
801025a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025b0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025b3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801025b6:	5b                   	pop    %ebx
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801025b7:	83 f9 19             	cmp    $0x19,%ecx
801025ba:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801025bd:	5d                   	pop    %ebp
801025be:	c3                   	ret    
801025bf:	90                   	nop
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801025c0:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
801025c7:	31 c0                	xor    %eax,%eax
801025c9:	c3                   	ret    
801025ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801025d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025d5:	c3                   	ret    
801025d6:	8d 76 00             	lea    0x0(%esi),%esi
801025d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025e0 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801025e6:	68 00 25 10 80       	push   $0x80102500
801025eb:	e8 f0 e1 ff ff       	call   801007e0 <consoleintr>
}
801025f0:	83 c4 10             	add    $0x10,%esp
801025f3:	c9                   	leave  
801025f4:	c3                   	ret    
801025f5:	66 90                	xchg   %ax,%ax
801025f7:	66 90                	xchg   %ax,%ax
801025f9:	66 90                	xchg   %ax,%ax
801025fb:	66 90                	xchg   %ax,%ax
801025fd:	66 90                	xchg   %ax,%ax
801025ff:	90                   	nop

80102600 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102600:	a1 7c 26 11 80       	mov    0x8011267c,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
80102605:	55                   	push   %ebp
80102606:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102608:	85 c0                	test   %eax,%eax
8010260a:	0f 84 c8 00 00 00    	je     801026d8 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102610:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102617:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010261a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010261d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102624:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102627:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010262a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102631:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102634:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102637:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010263e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102641:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102644:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010264b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010264e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102651:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102658:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010265b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010265e:	8b 50 30             	mov    0x30(%eax),%edx
80102661:	c1 ea 10             	shr    $0x10,%edx
80102664:	80 fa 03             	cmp    $0x3,%dl
80102667:	77 77                	ja     801026e0 <lapicinit+0xe0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102669:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102670:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102673:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102676:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010267d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102680:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102683:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010268a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010268d:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102690:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102697:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010269a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010269d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026a4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026a7:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026aa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801026b1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801026b4:	8b 50 20             	mov    0x20(%eax),%edx
801026b7:	89 f6                	mov    %esi,%esi
801026b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026c0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026c6:	80 e6 10             	and    $0x10,%dh
801026c9:	75 f5                	jne    801026c0 <lapicinit+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026cb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026d2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801026d8:	5d                   	pop    %ebp
801026d9:	c3                   	ret    
801026da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026e7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ea:	8b 50 20             	mov    0x20(%eax),%edx
801026ed:	e9 77 ff ff ff       	jmp    80102669 <lapicinit+0x69>
801026f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102700 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102700:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102705:	55                   	push   %ebp
80102706:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102708:	85 c0                	test   %eax,%eax
8010270a:	74 0c                	je     80102718 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010270c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010270f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102710:	c1 e8 18             	shr    $0x18,%eax
}
80102713:	c3                   	ret    
80102714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102718:	31 c0                	xor    %eax,%eax
8010271a:	5d                   	pop    %ebp
8010271b:	c3                   	ret    
8010271c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102720 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102720:	a1 7c 26 11 80       	mov    0x8011267c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102725:	55                   	push   %ebp
80102726:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102728:	85 c0                	test   %eax,%eax
8010272a:	74 0d                	je     80102739 <lapiceoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010272c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102733:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102736:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102739:	5d                   	pop    %ebp
8010273a:	c3                   	ret    
8010273b:	90                   	nop
8010273c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102740 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
}
80102743:	5d                   	pop    %ebp
80102744:	c3                   	ret    
80102745:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102750:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102751:	ba 70 00 00 00       	mov    $0x70,%edx
80102756:	b8 0f 00 00 00       	mov    $0xf,%eax
8010275b:	89 e5                	mov    %esp,%ebp
8010275d:	53                   	push   %ebx
8010275e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102761:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102764:	ee                   	out    %al,(%dx)
80102765:	ba 71 00 00 00       	mov    $0x71,%edx
8010276a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010276f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102770:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102772:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102775:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010277b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010277d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102780:	c1 e8 04             	shr    $0x4,%eax

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102783:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102785:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102788:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010278e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102793:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102799:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010279c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027a3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a6:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801027b0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027b3:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027bc:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027bf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027c5:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027c8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027ce:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027d1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027d7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801027da:	5b                   	pop    %ebx
801027db:	5d                   	pop    %ebp
801027dc:	c3                   	ret    
801027dd:	8d 76 00             	lea    0x0(%esi),%esi

801027e0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801027e0:	55                   	push   %ebp
801027e1:	ba 70 00 00 00       	mov    $0x70,%edx
801027e6:	b8 0b 00 00 00       	mov    $0xb,%eax
801027eb:	89 e5                	mov    %esp,%ebp
801027ed:	57                   	push   %edi
801027ee:	56                   	push   %esi
801027ef:	53                   	push   %ebx
801027f0:	83 ec 5c             	sub    $0x5c,%esp
801027f3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027f4:	ba 71 00 00 00       	mov    $0x71,%edx
801027f9:	ec                   	in     (%dx),%al
801027fa:	83 e0 04             	and    $0x4,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027fd:	bb 70 00 00 00       	mov    $0x70,%ebx
80102802:	88 45 a7             	mov    %al,-0x59(%ebp)
80102805:	8d 76 00             	lea    0x0(%esi),%esi
80102808:	31 c0                	xor    %eax,%eax
8010280a:	89 da                	mov    %ebx,%edx
8010280c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010280d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102812:	89 ca                	mov    %ecx,%edx
80102814:	ec                   	in     (%dx),%al
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
80102815:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102818:	89 da                	mov    %ebx,%edx
8010281a:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010281d:	b8 02 00 00 00       	mov    $0x2,%eax
80102822:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102823:	89 ca                	mov    %ecx,%edx
80102825:	ec                   	in     (%dx),%al
80102826:	0f b6 f0             	movzbl %al,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102829:	89 da                	mov    %ebx,%edx
8010282b:	b8 04 00 00 00       	mov    $0x4,%eax
80102830:	89 75 b0             	mov    %esi,-0x50(%ebp)
80102833:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102834:	89 ca                	mov    %ecx,%edx
80102836:	ec                   	in     (%dx),%al
80102837:	0f b6 f8             	movzbl %al,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010283a:	89 da                	mov    %ebx,%edx
8010283c:	b8 07 00 00 00       	mov    $0x7,%eax
80102841:	89 7d ac             	mov    %edi,-0x54(%ebp)
80102844:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102845:	89 ca                	mov    %ecx,%edx
80102847:	ec                   	in     (%dx),%al
80102848:	0f b6 d0             	movzbl %al,%edx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010284b:	b8 08 00 00 00       	mov    $0x8,%eax
80102850:	89 55 a8             	mov    %edx,-0x58(%ebp)
80102853:	89 da                	mov    %ebx,%edx
80102855:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102856:	89 ca                	mov    %ecx,%edx
80102858:	ec                   	in     (%dx),%al
80102859:	0f b6 f8             	movzbl %al,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010285c:	89 da                	mov    %ebx,%edx
8010285e:	b8 09 00 00 00       	mov    $0x9,%eax
80102863:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102864:	89 ca                	mov    %ecx,%edx
80102866:	ec                   	in     (%dx),%al
80102867:	0f b6 f0             	movzbl %al,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010286a:	89 da                	mov    %ebx,%edx
8010286c:	b8 0a 00 00 00       	mov    $0xa,%eax
80102871:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102872:	89 ca                	mov    %ecx,%edx
80102874:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102875:	84 c0                	test   %al,%al
80102877:	78 8f                	js     80102808 <cmostime+0x28>
80102879:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010287c:	8b 55 a8             	mov    -0x58(%ebp),%edx
8010287f:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102882:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102885:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102888:	8b 45 b0             	mov    -0x50(%ebp),%eax
8010288b:	89 55 c4             	mov    %edx,-0x3c(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010288e:	89 da                	mov    %ebx,%edx
80102890:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102893:	8b 45 ac             	mov    -0x54(%ebp),%eax
80102896:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102899:	31 c0                	xor    %eax,%eax
8010289b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289c:	89 ca                	mov    %ecx,%edx
8010289e:	ec                   	in     (%dx),%al
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
8010289f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a2:	89 da                	mov    %ebx,%edx
801028a4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028a7:	b8 02 00 00 00       	mov    $0x2,%eax
801028ac:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ad:	89 ca                	mov    %ecx,%edx
801028af:	ec                   	in     (%dx),%al
801028b0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b3:	89 da                	mov    %ebx,%edx
801028b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801028b8:	b8 04 00 00 00       	mov    $0x4,%eax
801028bd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028be:	89 ca                	mov    %ecx,%edx
801028c0:	ec                   	in     (%dx),%al
801028c1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c4:	89 da                	mov    %ebx,%edx
801028c6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801028c9:	b8 07 00 00 00       	mov    $0x7,%eax
801028ce:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028cf:	89 ca                	mov    %ecx,%edx
801028d1:	ec                   	in     (%dx),%al
801028d2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d5:	89 da                	mov    %ebx,%edx
801028d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801028da:	b8 08 00 00 00       	mov    $0x8,%eax
801028df:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e0:	89 ca                	mov    %ecx,%edx
801028e2:	ec                   	in     (%dx),%al
801028e3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e6:	89 da                	mov    %ebx,%edx
801028e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028eb:	b8 09 00 00 00       	mov    $0x9,%eax
801028f0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f1:	89 ca                	mov    %ecx,%edx
801028f3:	ec                   	in     (%dx),%al
801028f4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028f7:	83 ec 04             	sub    $0x4,%esp
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
801028fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028fd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102900:	6a 18                	push   $0x18
80102902:	50                   	push   %eax
80102903:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102906:	50                   	push   %eax
80102907:	e8 84 1d 00 00       	call   80104690 <memcmp>
8010290c:	83 c4 10             	add    $0x10,%esp
8010290f:	85 c0                	test   %eax,%eax
80102911:	0f 85 f1 fe ff ff    	jne    80102808 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102917:	80 7d a7 00          	cmpb   $0x0,-0x59(%ebp)
8010291b:	75 78                	jne    80102995 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010291d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102920:	89 c2                	mov    %eax,%edx
80102922:	83 e0 0f             	and    $0xf,%eax
80102925:	c1 ea 04             	shr    $0x4,%edx
80102928:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010292b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010292e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102931:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102934:	89 c2                	mov    %eax,%edx
80102936:	83 e0 0f             	and    $0xf,%eax
80102939:	c1 ea 04             	shr    $0x4,%edx
8010293c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010293f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102942:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102945:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102948:	89 c2                	mov    %eax,%edx
8010294a:	83 e0 0f             	and    $0xf,%eax
8010294d:	c1 ea 04             	shr    $0x4,%edx
80102950:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102953:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102956:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102959:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010295c:	89 c2                	mov    %eax,%edx
8010295e:	83 e0 0f             	and    $0xf,%eax
80102961:	c1 ea 04             	shr    $0x4,%edx
80102964:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102967:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010296a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010296d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102970:	89 c2                	mov    %eax,%edx
80102972:	83 e0 0f             	and    $0xf,%eax
80102975:	c1 ea 04             	shr    $0x4,%edx
80102978:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102981:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102984:	89 c2                	mov    %eax,%edx
80102986:	83 e0 0f             	and    $0xf,%eax
80102989:	c1 ea 04             	shr    $0x4,%edx
8010298c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102992:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102995:	8b 75 08             	mov    0x8(%ebp),%esi
80102998:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010299b:	89 06                	mov    %eax,(%esi)
8010299d:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029a0:	89 46 04             	mov    %eax,0x4(%esi)
801029a3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029a6:	89 46 08             	mov    %eax,0x8(%esi)
801029a9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ac:	89 46 0c             	mov    %eax,0xc(%esi)
801029af:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029b2:	89 46 10             	mov    %eax,0x10(%esi)
801029b5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029b8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801029bb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801029c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029c5:	5b                   	pop    %ebx
801029c6:	5e                   	pop    %esi
801029c7:	5f                   	pop    %edi
801029c8:	5d                   	pop    %ebp
801029c9:	c3                   	ret    
801029ca:	66 90                	xchg   %ax,%ax
801029cc:	66 90                	xchg   %ax,%ax
801029ce:	66 90                	xchg   %ax,%ax

801029d0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029d0:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
801029d6:	85 c9                	test   %ecx,%ecx
801029d8:	0f 8e 85 00 00 00    	jle    80102a63 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029de:	55                   	push   %ebp
801029df:	89 e5                	mov    %esp,%ebp
801029e1:	57                   	push   %edi
801029e2:	56                   	push   %esi
801029e3:	53                   	push   %ebx
801029e4:	31 db                	xor    %ebx,%ebx
801029e6:	83 ec 0c             	sub    $0xc,%esp
801029e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029f0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
801029f5:	83 ec 08             	sub    $0x8,%esp
801029f8:	01 d8                	add    %ebx,%eax
801029fa:	83 c0 01             	add    $0x1,%eax
801029fd:	50                   	push   %eax
801029fe:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a04:	e8 c7 d6 ff ff       	call   801000d0 <bread>
80102a09:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a0b:	58                   	pop    %eax
80102a0c:	5a                   	pop    %edx
80102a0d:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102a14:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a1a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a1d:	e8 ae d6 ff ff       	call   801000d0 <bread>
80102a22:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a24:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a27:	83 c4 0c             	add    $0xc,%esp
80102a2a:	68 00 02 00 00       	push   $0x200
80102a2f:	50                   	push   %eax
80102a30:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a33:	50                   	push   %eax
80102a34:	e8 b7 1c 00 00       	call   801046f0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a39:	89 34 24             	mov    %esi,(%esp)
80102a3c:	e8 5f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a41:	89 3c 24             	mov    %edi,(%esp)
80102a44:	e8 97 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a49:	89 34 24             	mov    %esi,(%esp)
80102a4c:	e8 8f d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a51:	83 c4 10             	add    $0x10,%esp
80102a54:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102a5a:	7f 94                	jg     801029f0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a5f:	5b                   	pop    %ebx
80102a60:	5e                   	pop    %esi
80102a61:	5f                   	pop    %edi
80102a62:	5d                   	pop    %ebp
80102a63:	f3 c3                	repz ret 
80102a65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	53                   	push   %ebx
80102a74:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a77:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102a7d:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102a83:	e8 48 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a88:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102a8e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102a91:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a93:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a95:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102a98:	7e 1f                	jle    80102ab9 <write_head+0x49>
80102a9a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102aa1:	31 d2                	xor    %edx,%edx
80102aa3:	90                   	nop
80102aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102aa8:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102aae:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102ab2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ab5:	39 c2                	cmp    %eax,%edx
80102ab7:	75 ef                	jne    80102aa8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102ab9:	83 ec 0c             	sub    $0xc,%esp
80102abc:	53                   	push   %ebx
80102abd:	e8 de d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102ac2:	89 1c 24             	mov    %ebx,(%esp)
80102ac5:	e8 16 d7 ff ff       	call   801001e0 <brelse>
}
80102aca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102acd:	c9                   	leave  
80102ace:	c3                   	ret    
80102acf:	90                   	nop

80102ad0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	53                   	push   %ebx
80102ad4:	83 ec 2c             	sub    $0x2c,%esp
80102ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102ada:	68 a0 76 10 80       	push   $0x801076a0
80102adf:	68 80 26 11 80       	push   $0x80112680
80102ae4:	e8 e7 18 00 00       	call   801043d0 <initlock>
  readsb(dev, &sb);
80102ae9:	58                   	pop    %eax
80102aea:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102aed:	5a                   	pop    %edx
80102aee:	50                   	push   %eax
80102aef:	53                   	push   %ebx
80102af0:	e8 bb e8 ff ff       	call   801013b0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102af5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102af8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102afb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102afc:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b02:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b08:	a3 b4 26 11 80       	mov    %eax,0x801126b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b0d:	5a                   	pop    %edx
80102b0e:	50                   	push   %eax
80102b0f:	53                   	push   %ebx
80102b10:	e8 bb d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b15:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b18:	83 c4 10             	add    $0x10,%esp
80102b1b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b1d:	89 0d c8 26 11 80    	mov    %ecx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102b23:	7e 1c                	jle    80102b41 <initlog+0x71>
80102b25:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b2c:	31 d2                	xor    %edx,%edx
80102b2e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b30:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b34:	83 c2 04             	add    $0x4,%edx
80102b37:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b3d:	39 da                	cmp    %ebx,%edx
80102b3f:	75 ef                	jne    80102b30 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b41:	83 ec 0c             	sub    $0xc,%esp
80102b44:	50                   	push   %eax
80102b45:	e8 96 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b4a:	e8 81 fe ff ff       	call   801029d0 <install_trans>
  log.lh.n = 0;
80102b4f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102b56:	00 00 00 
  write_head(); // clear the log
80102b59:	e8 12 ff ff ff       	call   80102a70 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b61:	c9                   	leave  
80102b62:	c3                   	ret    
80102b63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b70 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102b76:	68 80 26 11 80       	push   $0x80112680
80102b7b:	e8 50 19 00 00       	call   801044d0 <acquire>
80102b80:	83 c4 10             	add    $0x10,%esp
80102b83:	eb 18                	jmp    80102b9d <begin_op+0x2d>
80102b85:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b88:	83 ec 08             	sub    $0x8,%esp
80102b8b:	68 80 26 11 80       	push   $0x80112680
80102b90:	68 80 26 11 80       	push   $0x80112680
80102b95:	e8 e6 12 00 00       	call   80103e80 <sleep>
80102b9a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102b9d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102ba2:	85 c0                	test   %eax,%eax
80102ba4:	75 e2                	jne    80102b88 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ba6:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102bab:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102bb1:	83 c0 01             	add    $0x1,%eax
80102bb4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102bb7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bba:	83 fa 1e             	cmp    $0x1e,%edx
80102bbd:	7f c9                	jg     80102b88 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bbf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102bc2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102bc7:	68 80 26 11 80       	push   $0x80112680
80102bcc:	e8 1f 1a 00 00       	call   801045f0 <release>
      break;
    }
  }
}
80102bd1:	83 c4 10             	add    $0x10,%esp
80102bd4:	c9                   	leave  
80102bd5:	c3                   	ret    
80102bd6:	8d 76 00             	lea    0x0(%esi),%esi
80102bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102be0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	57                   	push   %edi
80102be4:	56                   	push   %esi
80102be5:	53                   	push   %ebx
80102be6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102be9:	68 80 26 11 80       	push   $0x80112680
80102bee:	e8 dd 18 00 00       	call   801044d0 <acquire>
  log.outstanding -= 1;
80102bf3:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102bf8:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102bfe:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c01:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c04:	85 f6                	test   %esi,%esi
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c06:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102c0c:	0f 85 22 01 00 00    	jne    80102d34 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102c12:	85 db                	test   %ebx,%ebx
80102c14:	0f 85 f6 00 00 00    	jne    80102d10 <end_op+0x130>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c1a:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c1d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102c24:	00 00 00 
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c27:	68 80 26 11 80       	push   $0x80112680
80102c2c:	e8 bf 19 00 00       	call   801045f0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c31:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c37:	83 c4 10             	add    $0x10,%esp
80102c3a:	85 c9                	test   %ecx,%ecx
80102c3c:	0f 8e 8b 00 00 00    	jle    80102ccd <end_op+0xed>
80102c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c48:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102c4d:	83 ec 08             	sub    $0x8,%esp
80102c50:	01 d8                	add    %ebx,%eax
80102c52:	83 c0 01             	add    $0x1,%eax
80102c55:	50                   	push   %eax
80102c56:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102c5c:	e8 6f d4 ff ff       	call   801000d0 <bread>
80102c61:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c63:	58                   	pop    %eax
80102c64:	5a                   	pop    %edx
80102c65:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102c6c:	ff 35 c4 26 11 80    	pushl  0x801126c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c72:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c75:	e8 56 d4 ff ff       	call   801000d0 <bread>
80102c7a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c7c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c7f:	83 c4 0c             	add    $0xc,%esp
80102c82:	68 00 02 00 00       	push   $0x200
80102c87:	50                   	push   %eax
80102c88:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c8b:	50                   	push   %eax
80102c8c:	e8 5f 1a 00 00       	call   801046f0 <memmove>
    bwrite(to);  // write the log
80102c91:	89 34 24             	mov    %esi,(%esp)
80102c94:	e8 07 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c99:	89 3c 24             	mov    %edi,(%esp)
80102c9c:	e8 3f d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ca1:	89 34 24             	mov    %esi,(%esp)
80102ca4:	e8 37 d5 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ca9:	83 c4 10             	add    $0x10,%esp
80102cac:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102cb2:	7c 94                	jl     80102c48 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cb4:	e8 b7 fd ff ff       	call   80102a70 <write_head>
    install_trans(); // Now install writes to home locations
80102cb9:	e8 12 fd ff ff       	call   801029d0 <install_trans>
    log.lh.n = 0;
80102cbe:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102cc5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cc8:	e8 a3 fd ff ff       	call   80102a70 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102ccd:	83 ec 0c             	sub    $0xc,%esp
80102cd0:	68 80 26 11 80       	push   $0x80112680
80102cd5:	e8 f6 17 00 00       	call   801044d0 <acquire>
    log.committing = 0;
    wakeup(&log);
80102cda:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102ce1:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102ce8:	00 00 00 
    wakeup(&log);
80102ceb:	e8 50 13 00 00       	call   80104040 <wakeup>
    release(&log.lock);
80102cf0:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cf7:	e8 f4 18 00 00       	call   801045f0 <release>
80102cfc:	83 c4 10             	add    $0x10,%esp
  }
}
80102cff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d02:	5b                   	pop    %ebx
80102d03:	5e                   	pop    %esi
80102d04:	5f                   	pop    %edi
80102d05:	5d                   	pop    %ebp
80102d06:	c3                   	ret    
80102d07:	89 f6                	mov    %esi,%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80102d10:	83 ec 0c             	sub    $0xc,%esp
80102d13:	68 80 26 11 80       	push   $0x80112680
80102d18:	e8 23 13 00 00       	call   80104040 <wakeup>
  }
  release(&log.lock);
80102d1d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d24:	e8 c7 18 00 00       	call   801045f0 <release>
80102d29:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102d2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d2f:	5b                   	pop    %ebx
80102d30:	5e                   	pop    %esi
80102d31:	5f                   	pop    %edi
80102d32:	5d                   	pop    %ebp
80102d33:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d34:	83 ec 0c             	sub    $0xc,%esp
80102d37:	68 a4 76 10 80       	push   $0x801076a4
80102d3c:	e8 2f d6 ff ff       	call   80100370 <panic>
80102d41:	eb 0d                	jmp    80102d50 <log_write>
80102d43:	90                   	nop
80102d44:	90                   	nop
80102d45:	90                   	nop
80102d46:	90                   	nop
80102d47:	90                   	nop
80102d48:	90                   	nop
80102d49:	90                   	nop
80102d4a:	90                   	nop
80102d4b:	90                   	nop
80102d4c:	90                   	nop
80102d4d:	90                   	nop
80102d4e:	90                   	nop
80102d4f:	90                   	nop

80102d50 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d50:	55                   	push   %ebp
80102d51:	89 e5                	mov    %esp,%ebp
80102d53:	53                   	push   %ebx
80102d54:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d57:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d60:	83 fa 1d             	cmp    $0x1d,%edx
80102d63:	0f 8f 97 00 00 00    	jg     80102e00 <log_write+0xb0>
80102d69:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102d6e:	83 e8 01             	sub    $0x1,%eax
80102d71:	39 c2                	cmp    %eax,%edx
80102d73:	0f 8d 87 00 00 00    	jge    80102e00 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d79:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102d7e:	85 c0                	test   %eax,%eax
80102d80:	0f 8e 87 00 00 00    	jle    80102e0d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d86:	83 ec 0c             	sub    $0xc,%esp
80102d89:	68 80 26 11 80       	push   $0x80112680
80102d8e:	e8 3d 17 00 00       	call   801044d0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d93:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d99:	83 c4 10             	add    $0x10,%esp
80102d9c:	83 f9 00             	cmp    $0x0,%ecx
80102d9f:	7e 50                	jle    80102df1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102da1:	8b 53 08             	mov    0x8(%ebx),%edx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102da4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102da6:	3b 15 cc 26 11 80    	cmp    0x801126cc,%edx
80102dac:	75 0b                	jne    80102db9 <log_write+0x69>
80102dae:	eb 38                	jmp    80102de8 <log_write+0x98>
80102db0:	39 14 85 cc 26 11 80 	cmp    %edx,-0x7feed934(,%eax,4)
80102db7:	74 2f                	je     80102de8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102db9:	83 c0 01             	add    $0x1,%eax
80102dbc:	39 c8                	cmp    %ecx,%eax
80102dbe:	75 f0                	jne    80102db0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102dc0:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102dc7:	83 c0 01             	add    $0x1,%eax
80102dca:	a3 c8 26 11 80       	mov    %eax,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102dcf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102dd2:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102dd9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ddc:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102ddd:	e9 0e 18 00 00       	jmp    801045f0 <release>
80102de2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102de8:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102def:	eb de                	jmp    80102dcf <log_write+0x7f>
80102df1:	8b 43 08             	mov    0x8(%ebx),%eax
80102df4:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102df9:	75 d4                	jne    80102dcf <log_write+0x7f>
80102dfb:	31 c0                	xor    %eax,%eax
80102dfd:	eb c8                	jmp    80102dc7 <log_write+0x77>
80102dff:	90                   	nop
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e00:	83 ec 0c             	sub    $0xc,%esp
80102e03:	68 b3 76 10 80       	push   $0x801076b3
80102e08:	e8 63 d5 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e0d:	83 ec 0c             	sub    $0xc,%esp
80102e10:	68 c9 76 10 80       	push   $0x801076c9
80102e15:	e8 56 d5 ff ff       	call   80100370 <panic>
80102e1a:	66 90                	xchg   %ax,%ax
80102e1c:	66 90                	xchg   %ax,%ax
80102e1e:	66 90                	xchg   %ax,%ax

80102e20 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
80102e24:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e27:	e8 84 0a 00 00       	call   801038b0 <cpuid>
80102e2c:	89 c3                	mov    %eax,%ebx
80102e2e:	e8 7d 0a 00 00       	call   801038b0 <cpuid>
80102e33:	83 ec 04             	sub    $0x4,%esp
80102e36:	53                   	push   %ebx
80102e37:	50                   	push   %eax
80102e38:	68 e4 76 10 80       	push   $0x801076e4
80102e3d:	e8 1e d8 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e42:	e8 e9 2b 00 00       	call   80105a30 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e47:	e8 e4 09 00 00       	call   80103830 <mycpu>
80102e4c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e4e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e53:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e5a:	e8 31 0d 00 00       	call   80103b90 <scheduler>
80102e5f:	90                   	nop

80102e60 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e66:	e8 e5 3c 00 00       	call   80106b50 <switchkvm>
  seginit();
80102e6b:	e8 e0 3b 00 00       	call   80106a50 <seginit>
  lapicinit();
80102e70:	e8 8b f7 ff ff       	call   80102600 <lapicinit>
  mpmain();
80102e75:	e8 a6 ff ff ff       	call   80102e20 <mpmain>
80102e7a:	66 90                	xchg   %ax,%ax
80102e7c:	66 90                	xchg   %ax,%ax
80102e7e:	66 90                	xchg   %ax,%ax

80102e80 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102e80:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102e84:	83 e4 f0             	and    $0xfffffff0,%esp
80102e87:	ff 71 fc             	pushl  -0x4(%ecx)
80102e8a:	55                   	push   %ebp
80102e8b:	89 e5                	mov    %esp,%ebp
80102e8d:	53                   	push   %ebx
80102e8e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e8f:	83 ec 08             	sub    $0x8,%esp
80102e92:	68 00 00 40 80       	push   $0x80400000
80102e97:	68 a8 5c 11 80       	push   $0x80115ca8
80102e9c:	e8 1f f5 ff ff       	call   801023c0 <kinit1>
  kvmalloc();      // kernel page table
80102ea1:	e8 3a 41 00 00       	call   80106fe0 <kvmalloc>
  mpinit();        // detect other processors
80102ea6:	e8 85 01 00 00       	call   80103030 <mpinit>
  lapicinit();     // interrupt controller
80102eab:	e8 50 f7 ff ff       	call   80102600 <lapicinit>
  seginit();       // segment descriptors
80102eb0:	e8 9b 3b 00 00       	call   80106a50 <seginit>
  picinit();       // another interrupt controller
80102eb5:	e8 86 03 00 00       	call   80103240 <picinit>
  ioapicinit();    // another interrupt controller
80102eba:	e8 21 f3 ff ff       	call   801021e0 <ioapicinit>
  consoleinit();   // console hardware
80102ebf:	e8 cc da ff ff       	call   80100990 <consoleinit>
  uartinit();      // serial port
80102ec4:	e8 57 2e 00 00       	call   80105d20 <uartinit>
  pinit();         // process table
80102ec9:	e8 42 09 00 00       	call   80103810 <pinit>
  tvinit();        // trap vectors
80102ece:	e8 bd 2a 00 00       	call   80105990 <tvinit>
  binit();         // buffer cache
80102ed3:	e8 68 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ed8:	e8 63 de ff ff       	call   80100d40 <fileinit>
  ideinit();       // disk 
80102edd:	e8 ce f0 ff ff       	call   80101fb0 <ideinit>
  if(!ismp)
80102ee2:	a1 64 27 11 80       	mov    0x80112764,%eax
80102ee7:	83 c4 10             	add    $0x10,%esp
80102eea:	85 c0                	test   %eax,%eax
80102eec:	0f 84 bd 00 00 00    	je     80102faf <main+0x12f>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102ef2:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80102ef5:	bb 80 27 11 80       	mov    $0x80112780,%ebx

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102efa:	68 8a 00 00 00       	push   $0x8a
80102eff:	68 8c a4 10 80       	push   $0x8010a48c
80102f04:	68 00 70 00 80       	push   $0x80007000
80102f09:	e8 e2 17 00 00       	call   801046f0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f0e:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f15:	00 00 00 
80102f18:	83 c4 10             	add    $0x10,%esp
80102f1b:	05 80 27 11 80       	add    $0x80112780,%eax
80102f20:	39 d8                	cmp    %ebx,%eax
80102f22:	76 6f                	jbe    80102f93 <main+0x113>
80102f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102f28:	e8 03 09 00 00       	call   80103830 <mycpu>
80102f2d:	39 d8                	cmp    %ebx,%eax
80102f2f:	74 49                	je     80102f7a <main+0xfa>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f31:	e8 5a f5 ff ff       	call   80102490 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f36:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80102f3b:	c7 05 f8 6f 00 80 60 	movl   $0x80102e60,0x80006ff8
80102f42:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f45:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f4c:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f4f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f54:	0f b6 03             	movzbl (%ebx),%eax
80102f57:	83 ec 08             	sub    $0x8,%esp
80102f5a:	68 00 70 00 00       	push   $0x7000
80102f5f:	50                   	push   %eax
80102f60:	e8 eb f7 ff ff       	call   80102750 <lapicstartap>
80102f65:	83 c4 10             	add    $0x10,%esp
80102f68:	90                   	nop
80102f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f70:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f76:	85 c0                	test   %eax,%eax
80102f78:	74 f6                	je     80102f70 <main+0xf0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f7a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f81:	00 00 00 
80102f84:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f8a:	05 80 27 11 80       	add    $0x80112780,%eax
80102f8f:	39 c3                	cmp    %eax,%ebx
80102f91:	72 95                	jb     80102f28 <main+0xa8>
  fileinit();      // file table
  ideinit();       // disk 
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f93:	83 ec 08             	sub    $0x8,%esp
80102f96:	68 00 00 00 8e       	push   $0x8e000000
80102f9b:	68 00 00 40 80       	push   $0x80400000
80102fa0:	e8 8b f4 ff ff       	call   80102430 <kinit2>
  userinit();      // first user process
80102fa5:	e8 56 09 00 00       	call   80103900 <userinit>
  mpmain();        // finish this processor's setup
80102faa:	e8 71 fe ff ff       	call   80102e20 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  if(!ismp)
    timerinit();   // uniprocessor timer
80102faf:	e8 7c 29 00 00       	call   80105930 <timerinit>
80102fb4:	e9 39 ff ff ff       	jmp    80102ef2 <main+0x72>
80102fb9:	66 90                	xchg   %ax,%ax
80102fbb:	66 90                	xchg   %ax,%ax
80102fbd:	66 90                	xchg   %ax,%ax
80102fbf:	90                   	nop

80102fc0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	57                   	push   %edi
80102fc4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fc5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fcb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102fcc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fcf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fd2:	39 de                	cmp    %ebx,%esi
80102fd4:	73 40                	jae    80103016 <mpsearch1+0x56>
80102fd6:	8d 76 00             	lea    0x0(%esi),%esi
80102fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fe0:	83 ec 04             	sub    $0x4,%esp
80102fe3:	8d 7e 10             	lea    0x10(%esi),%edi
80102fe6:	6a 04                	push   $0x4
80102fe8:	68 f8 76 10 80       	push   $0x801076f8
80102fed:	56                   	push   %esi
80102fee:	e8 9d 16 00 00       	call   80104690 <memcmp>
80102ff3:	83 c4 10             	add    $0x10,%esp
80102ff6:	85 c0                	test   %eax,%eax
80102ff8:	75 16                	jne    80103010 <mpsearch1+0x50>
80102ffa:	8d 7e 10             	lea    0x10(%esi),%edi
80102ffd:	89 f2                	mov    %esi,%edx
80102fff:	90                   	nop
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103000:	0f b6 0a             	movzbl (%edx),%ecx
80103003:	83 c2 01             	add    $0x1,%edx
80103006:	01 c8                	add    %ecx,%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103008:	39 fa                	cmp    %edi,%edx
8010300a:	75 f4                	jne    80103000 <mpsearch1+0x40>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010300c:	84 c0                	test   %al,%al
8010300e:	74 10                	je     80103020 <mpsearch1+0x60>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103010:	39 fb                	cmp    %edi,%ebx
80103012:	89 fe                	mov    %edi,%esi
80103014:	77 ca                	ja     80102fe0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80103016:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103019:	31 c0                	xor    %eax,%eax
}
8010301b:	5b                   	pop    %ebx
8010301c:	5e                   	pop    %esi
8010301d:	5f                   	pop    %edi
8010301e:	5d                   	pop    %ebp
8010301f:	c3                   	ret    
80103020:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103023:	89 f0                	mov    %esi,%eax
80103025:	5b                   	pop    %ebx
80103026:	5e                   	pop    %esi
80103027:	5f                   	pop    %edi
80103028:	5d                   	pop    %ebp
80103029:	c3                   	ret    
8010302a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103030 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	57                   	push   %edi
80103034:	56                   	push   %esi
80103035:	53                   	push   %ebx
80103036:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103039:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103040:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103047:	c1 e0 08             	shl    $0x8,%eax
8010304a:	09 d0                	or     %edx,%eax
8010304c:	c1 e0 04             	shl    $0x4,%eax
8010304f:	85 c0                	test   %eax,%eax
80103051:	75 1b                	jne    8010306e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103053:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010305a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103061:	c1 e0 08             	shl    $0x8,%eax
80103064:	09 d0                	or     %edx,%eax
80103066:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103069:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010306e:	ba 00 04 00 00       	mov    $0x400,%edx
80103073:	e8 48 ff ff ff       	call   80102fc0 <mpsearch1>
80103078:	85 c0                	test   %eax,%eax
8010307a:	89 c6                	mov    %eax,%esi
8010307c:	0f 84 66 01 00 00    	je     801031e8 <mpinit+0x1b8>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103082:	8b 5e 04             	mov    0x4(%esi),%ebx
80103085:	85 db                	test   %ebx,%ebx
80103087:	0f 84 d6 00 00 00    	je     80103163 <mpinit+0x133>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010308d:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103093:	83 ec 04             	sub    $0x4,%esp
80103096:	6a 04                	push   $0x4
80103098:	68 fd 76 10 80       	push   $0x801076fd
8010309d:	50                   	push   %eax
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010309e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801030a1:	e8 ea 15 00 00       	call   80104690 <memcmp>
801030a6:	83 c4 10             	add    $0x10,%esp
801030a9:	85 c0                	test   %eax,%eax
801030ab:	0f 85 b2 00 00 00    	jne    80103163 <mpinit+0x133>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801030b1:	0f b6 93 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%edx
801030b8:	80 fa 01             	cmp    $0x1,%dl
801030bb:	74 09                	je     801030c6 <mpinit+0x96>
801030bd:	80 fa 04             	cmp    $0x4,%dl
801030c0:	0f 85 9d 00 00 00    	jne    80103163 <mpinit+0x133>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030c6:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030cd:	85 ff                	test   %edi,%edi
801030cf:	74 1c                	je     801030ed <mpinit+0xbd>
801030d1:	31 d2                	xor    %edx,%edx
801030d3:	90                   	nop
801030d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801030d8:	0f b6 8c 13 00 00 00 	movzbl -0x80000000(%ebx,%edx,1),%ecx
801030df:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030e0:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801030e3:	01 c8                	add    %ecx,%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030e5:	39 d7                	cmp    %edx,%edi
801030e7:	75 ef                	jne    801030d8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030e9:	84 c0                	test   %al,%al
801030eb:	75 76                	jne    80103163 <mpinit+0x133>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801030ed:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801030f0:	85 ff                	test   %edi,%edi
801030f2:	74 6f                	je     80103163 <mpinit+0x133>
    return;
  ismp = 1;
801030f4:	c7 05 64 27 11 80 01 	movl   $0x1,0x80112764
801030fb:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801030fe:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103104:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103109:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80103110:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103116:	01 f9                	add    %edi,%ecx
80103118:	39 c8                	cmp    %ecx,%eax
8010311a:	0f 83 a0 00 00 00    	jae    801031c0 <mpinit+0x190>
    switch(*p){
80103120:	80 38 04             	cmpb   $0x4,(%eax)
80103123:	0f 87 87 00 00 00    	ja     801031b0 <mpinit+0x180>
80103129:	0f b6 10             	movzbl (%eax),%edx
8010312c:	ff 24 95 04 77 10 80 	jmp    *-0x7fef88fc(,%edx,4)
80103133:	90                   	nop
80103134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103138:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010313b:	39 c1                	cmp    %eax,%ecx
8010313d:	77 e1                	ja     80103120 <mpinit+0xf0>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010313f:	a1 64 27 11 80       	mov    0x80112764,%eax
80103144:	85 c0                	test   %eax,%eax
80103146:	75 78                	jne    801031c0 <mpinit+0x190>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103148:	c7 05 00 2d 11 80 01 	movl   $0x1,0x80112d00
8010314f:	00 00 00 
    lapic = 0;
80103152:	c7 05 7c 26 11 80 00 	movl   $0x0,0x8011267c
80103159:	00 00 00 
    ioapicid = 0;
8010315c:	c6 05 60 27 11 80 00 	movb   $0x0,0x80112760
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103163:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103166:	5b                   	pop    %ebx
80103167:	5e                   	pop    %esi
80103168:	5f                   	pop    %edi
80103169:	5d                   	pop    %ebp
8010316a:	c3                   	ret    
8010316b:	90                   	nop
8010316c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103170:	8b 15 00 2d 11 80    	mov    0x80112d00,%edx
80103176:	83 fa 07             	cmp    $0x7,%edx
80103179:	7f 19                	jg     80103194 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010317b:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
8010317f:	69 fa b0 00 00 00    	imul   $0xb0,%edx,%edi
        ncpu++;
80103185:	83 c2 01             	add    $0x1,%edx
80103188:	89 15 00 2d 11 80    	mov    %edx,0x80112d00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010318e:	88 9f 80 27 11 80    	mov    %bl,-0x7feed880(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
80103194:	83 c0 14             	add    $0x14,%eax
      continue;
80103197:	eb a2                	jmp    8010313b <mpinit+0x10b>
80103199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031a0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031a4:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801031a7:	88 15 60 27 11 80    	mov    %dl,0x80112760
      p += sizeof(struct mpioapic);
      continue;
801031ad:	eb 8c                	jmp    8010313b <mpinit+0x10b>
801031af:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801031b0:	c7 05 64 27 11 80 00 	movl   $0x0,0x80112764
801031b7:	00 00 00 
      break;
801031ba:	e9 7c ff ff ff       	jmp    8010313b <mpinit+0x10b>
801031bf:	90                   	nop
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
801031c0:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801031c4:	74 9d                	je     80103163 <mpinit+0x133>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031c6:	ba 22 00 00 00       	mov    $0x22,%edx
801031cb:	b8 70 00 00 00       	mov    $0x70,%eax
801031d0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031d1:	ba 23 00 00 00       	mov    $0x23,%edx
801031d6:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801031d7:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031da:	ee                   	out    %al,(%dx)
  }
}
801031db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031de:	5b                   	pop    %ebx
801031df:	5e                   	pop    %esi
801031e0:	5f                   	pop    %edi
801031e1:	5d                   	pop    %ebp
801031e2:	c3                   	ret    
801031e3:	90                   	nop
801031e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031e8:	ba 00 00 01 00       	mov    $0x10000,%edx
801031ed:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031f2:	e8 c9 fd ff ff       	call   80102fc0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031f7:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031f9:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031fb:	0f 85 81 fe ff ff    	jne    80103082 <mpinit+0x52>
80103201:	e9 5d ff ff ff       	jmp    80103163 <mpinit+0x133>
80103206:	66 90                	xchg   %ax,%ax
80103208:	66 90                	xchg   %ax,%ax
8010320a:	66 90                	xchg   %ax,%ax
8010320c:	66 90                	xchg   %ax,%ax
8010320e:	66 90                	xchg   %ax,%ax

80103210 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103210:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103211:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103216:	ba 21 00 00 00       	mov    $0x21,%edx
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
8010321b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010321d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103220:	d3 c0                	rol    %cl,%eax
80103222:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
80103229:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
8010322f:	ee                   	out    %al,(%dx)
80103230:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
80103235:	66 c1 e8 08          	shr    $0x8,%ax
80103239:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
8010323a:	5d                   	pop    %ebp
8010323b:	c3                   	ret    
8010323c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103240 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103240:	55                   	push   %ebp
80103241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103246:	89 e5                	mov    %esp,%ebp
80103248:	57                   	push   %edi
80103249:	56                   	push   %esi
8010324a:	53                   	push   %ebx
8010324b:	bb 21 00 00 00       	mov    $0x21,%ebx
80103250:	89 da                	mov    %ebx,%edx
80103252:	ee                   	out    %al,(%dx)
80103253:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80103258:	89 ca                	mov    %ecx,%edx
8010325a:	ee                   	out    %al,(%dx)
8010325b:	bf 11 00 00 00       	mov    $0x11,%edi
80103260:	be 20 00 00 00       	mov    $0x20,%esi
80103265:	89 f8                	mov    %edi,%eax
80103267:	89 f2                	mov    %esi,%edx
80103269:	ee                   	out    %al,(%dx)
8010326a:	b8 20 00 00 00       	mov    $0x20,%eax
8010326f:	89 da                	mov    %ebx,%edx
80103271:	ee                   	out    %al,(%dx)
80103272:	b8 04 00 00 00       	mov    $0x4,%eax
80103277:	ee                   	out    %al,(%dx)
80103278:	b8 03 00 00 00       	mov    $0x3,%eax
8010327d:	ee                   	out    %al,(%dx)
8010327e:	bb a0 00 00 00       	mov    $0xa0,%ebx
80103283:	89 f8                	mov    %edi,%eax
80103285:	89 da                	mov    %ebx,%edx
80103287:	ee                   	out    %al,(%dx)
80103288:	b8 28 00 00 00       	mov    $0x28,%eax
8010328d:	89 ca                	mov    %ecx,%edx
8010328f:	ee                   	out    %al,(%dx)
80103290:	b8 02 00 00 00       	mov    $0x2,%eax
80103295:	ee                   	out    %al,(%dx)
80103296:	b8 03 00 00 00       	mov    $0x3,%eax
8010329b:	ee                   	out    %al,(%dx)
8010329c:	bf 68 00 00 00       	mov    $0x68,%edi
801032a1:	89 f2                	mov    %esi,%edx
801032a3:	89 f8                	mov    %edi,%eax
801032a5:	ee                   	out    %al,(%dx)
801032a6:	b9 0a 00 00 00       	mov    $0xa,%ecx
801032ab:	89 c8                	mov    %ecx,%eax
801032ad:	ee                   	out    %al,(%dx)
801032ae:	89 f8                	mov    %edi,%eax
801032b0:	89 da                	mov    %ebx,%edx
801032b2:	ee                   	out    %al,(%dx)
801032b3:	89 c8                	mov    %ecx,%eax
801032b5:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
801032b6:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
801032bd:	66 83 f8 ff          	cmp    $0xffff,%ax
801032c1:	74 10                	je     801032d3 <picinit+0x93>
801032c3:	ba 21 00 00 00       	mov    $0x21,%edx
801032c8:	ee                   	out    %al,(%dx)
801032c9:	ba a1 00 00 00       	mov    $0xa1,%edx
static void
picsetmask(ushort mask)
{
  irqmask = mask;
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
801032ce:	66 c1 e8 08          	shr    $0x8,%ax
801032d2:	ee                   	out    %al,(%dx)
  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
}
801032d3:	5b                   	pop    %ebx
801032d4:	5e                   	pop    %esi
801032d5:	5f                   	pop    %edi
801032d6:	5d                   	pop    %ebp
801032d7:	c3                   	ret    
801032d8:	66 90                	xchg   %ax,%ax
801032da:	66 90                	xchg   %ax,%ax
801032dc:	66 90                	xchg   %ax,%ax
801032de:	66 90                	xchg   %ax,%ax

801032e0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801032e0:	55                   	push   %ebp
801032e1:	89 e5                	mov    %esp,%ebp
801032e3:	57                   	push   %edi
801032e4:	56                   	push   %esi
801032e5:	53                   	push   %ebx
801032e6:	83 ec 0c             	sub    $0xc,%esp
801032e9:	8b 75 08             	mov    0x8(%ebp),%esi
801032ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801032ef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801032f5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801032fb:	e8 60 da ff ff       	call   80100d60 <filealloc>
80103300:	85 c0                	test   %eax,%eax
80103302:	89 06                	mov    %eax,(%esi)
80103304:	0f 84 a8 00 00 00    	je     801033b2 <pipealloc+0xd2>
8010330a:	e8 51 da ff ff       	call   80100d60 <filealloc>
8010330f:	85 c0                	test   %eax,%eax
80103311:	89 03                	mov    %eax,(%ebx)
80103313:	0f 84 87 00 00 00    	je     801033a0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103319:	e8 72 f1 ff ff       	call   80102490 <kalloc>
8010331e:	85 c0                	test   %eax,%eax
80103320:	89 c7                	mov    %eax,%edi
80103322:	0f 84 b0 00 00 00    	je     801033d8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103328:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010332b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103332:	00 00 00 
  p->writeopen = 1;
80103335:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010333c:	00 00 00 
  p->nwrite = 0;
8010333f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103346:	00 00 00 
  p->nread = 0;
80103349:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103350:	00 00 00 
  initlock(&p->lock, "pipe");
80103353:	68 18 77 10 80       	push   $0x80107718
80103358:	50                   	push   %eax
80103359:	e8 72 10 00 00       	call   801043d0 <initlock>
  (*f0)->type = FD_PIPE;
8010335e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103360:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103363:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103369:	8b 06                	mov    (%esi),%eax
8010336b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010336f:	8b 06                	mov    (%esi),%eax
80103371:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103375:	8b 06                	mov    (%esi),%eax
80103377:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010337a:	8b 03                	mov    (%ebx),%eax
8010337c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103382:	8b 03                	mov    (%ebx),%eax
80103384:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103388:	8b 03                	mov    (%ebx),%eax
8010338a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010338e:	8b 03                	mov    (%ebx),%eax
80103390:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103393:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103396:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103398:	5b                   	pop    %ebx
80103399:	5e                   	pop    %esi
8010339a:	5f                   	pop    %edi
8010339b:	5d                   	pop    %ebp
8010339c:	c3                   	ret    
8010339d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033a0:	8b 06                	mov    (%esi),%eax
801033a2:	85 c0                	test   %eax,%eax
801033a4:	74 1e                	je     801033c4 <pipealloc+0xe4>
    fileclose(*f0);
801033a6:	83 ec 0c             	sub    $0xc,%esp
801033a9:	50                   	push   %eax
801033aa:	e8 71 da ff ff       	call   80100e20 <fileclose>
801033af:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801033b2:	8b 03                	mov    (%ebx),%eax
801033b4:	85 c0                	test   %eax,%eax
801033b6:	74 0c                	je     801033c4 <pipealloc+0xe4>
    fileclose(*f1);
801033b8:	83 ec 0c             	sub    $0xc,%esp
801033bb:	50                   	push   %eax
801033bc:	e8 5f da ff ff       	call   80100e20 <fileclose>
801033c1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801033c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801033c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801033cc:	5b                   	pop    %ebx
801033cd:	5e                   	pop    %esi
801033ce:	5f                   	pop    %edi
801033cf:	5d                   	pop    %ebp
801033d0:	c3                   	ret    
801033d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033d8:	8b 06                	mov    (%esi),%eax
801033da:	85 c0                	test   %eax,%eax
801033dc:	75 c8                	jne    801033a6 <pipealloc+0xc6>
801033de:	eb d2                	jmp    801033b2 <pipealloc+0xd2>

801033e0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	56                   	push   %esi
801033e4:	53                   	push   %ebx
801033e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801033eb:	83 ec 0c             	sub    $0xc,%esp
801033ee:	53                   	push   %ebx
801033ef:	e8 dc 10 00 00       	call   801044d0 <acquire>
  if(writable){
801033f4:	83 c4 10             	add    $0x10,%esp
801033f7:	85 f6                	test   %esi,%esi
801033f9:	74 45                	je     80103440 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801033fb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103401:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103404:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010340b:	00 00 00 
    wakeup(&p->nread);
8010340e:	50                   	push   %eax
8010340f:	e8 2c 0c 00 00       	call   80104040 <wakeup>
80103414:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103417:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010341d:	85 d2                	test   %edx,%edx
8010341f:	75 0a                	jne    8010342b <pipeclose+0x4b>
80103421:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103427:	85 c0                	test   %eax,%eax
80103429:	74 35                	je     80103460 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010342b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010342e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103431:	5b                   	pop    %ebx
80103432:	5e                   	pop    %esi
80103433:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103434:	e9 b7 11 00 00       	jmp    801045f0 <release>
80103439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103440:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103446:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103449:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103450:	00 00 00 
    wakeup(&p->nwrite);
80103453:	50                   	push   %eax
80103454:	e8 e7 0b 00 00       	call   80104040 <wakeup>
80103459:	83 c4 10             	add    $0x10,%esp
8010345c:	eb b9                	jmp    80103417 <pipeclose+0x37>
8010345e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103460:	83 ec 0c             	sub    $0xc,%esp
80103463:	53                   	push   %ebx
80103464:	e8 87 11 00 00       	call   801045f0 <release>
    kfree((char*)p);
80103469:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010346c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010346f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103472:	5b                   	pop    %ebx
80103473:	5e                   	pop    %esi
80103474:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103475:	e9 66 ee ff ff       	jmp    801022e0 <kfree>
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103480 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	57                   	push   %edi
80103484:	56                   	push   %esi
80103485:	53                   	push   %ebx
80103486:	83 ec 28             	sub    $0x28,%esp
80103489:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010348c:	53                   	push   %ebx
8010348d:	e8 3e 10 00 00       	call   801044d0 <acquire>
  for(i = 0; i < n; i++){
80103492:	8b 45 10             	mov    0x10(%ebp),%eax
80103495:	83 c4 10             	add    $0x10,%esp
80103498:	85 c0                	test   %eax,%eax
8010349a:	0f 8e ca 00 00 00    	jle    8010356a <pipewrite+0xea>
801034a0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034a3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034a9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801034af:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801034b2:	03 4d 10             	add    0x10(%ebp),%ecx
801034b5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034b8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801034be:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801034c4:	39 d0                	cmp    %edx,%eax
801034c6:	75 71                	jne    80103539 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801034c8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034ce:	85 c0                	test   %eax,%eax
801034d0:	74 4e                	je     80103520 <pipewrite+0xa0>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034d2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801034d8:	eb 3a                	jmp    80103514 <pipewrite+0x94>
801034da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034e0:	83 ec 0c             	sub    $0xc,%esp
801034e3:	57                   	push   %edi
801034e4:	e8 57 0b 00 00       	call   80104040 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034e9:	5a                   	pop    %edx
801034ea:	59                   	pop    %ecx
801034eb:	53                   	push   %ebx
801034ec:	56                   	push   %esi
801034ed:	e8 8e 09 00 00       	call   80103e80 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034f2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801034f8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801034fe:	83 c4 10             	add    $0x10,%esp
80103501:	05 00 02 00 00       	add    $0x200,%eax
80103506:	39 c2                	cmp    %eax,%edx
80103508:	75 36                	jne    80103540 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010350a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103510:	85 c0                	test   %eax,%eax
80103512:	74 0c                	je     80103520 <pipewrite+0xa0>
80103514:	e8 b7 03 00 00       	call   801038d0 <myproc>
80103519:	8b 40 24             	mov    0x24(%eax),%eax
8010351c:	85 c0                	test   %eax,%eax
8010351e:	74 c0                	je     801034e0 <pipewrite+0x60>
        release(&p->lock);
80103520:	83 ec 0c             	sub    $0xc,%esp
80103523:	53                   	push   %ebx
80103524:	e8 c7 10 00 00       	call   801045f0 <release>
        return -1;
80103529:	83 c4 10             	add    $0x10,%esp
8010352c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103531:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103534:	5b                   	pop    %ebx
80103535:	5e                   	pop    %esi
80103536:	5f                   	pop    %edi
80103537:	5d                   	pop    %ebp
80103538:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103539:	89 c2                	mov    %eax,%edx
8010353b:	90                   	nop
8010353c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103540:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103543:	8d 42 01             	lea    0x1(%edx),%eax
80103546:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010354c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103552:	0f b6 0e             	movzbl (%esi),%ecx
80103555:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
80103559:	89 f1                	mov    %esi,%ecx
8010355b:	83 c1 01             	add    $0x1,%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010355e:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103561:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103564:	0f 85 4e ff ff ff    	jne    801034b8 <pipewrite+0x38>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010356a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	50                   	push   %eax
80103574:	e8 c7 0a 00 00       	call   80104040 <wakeup>
  release(&p->lock);
80103579:	89 1c 24             	mov    %ebx,(%esp)
8010357c:	e8 6f 10 00 00       	call   801045f0 <release>
  return n;
80103581:	83 c4 10             	add    $0x10,%esp
80103584:	8b 45 10             	mov    0x10(%ebp),%eax
80103587:	eb a8                	jmp    80103531 <pipewrite+0xb1>
80103589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103590 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103590:	55                   	push   %ebp
80103591:	89 e5                	mov    %esp,%ebp
80103593:	57                   	push   %edi
80103594:	56                   	push   %esi
80103595:	53                   	push   %ebx
80103596:	83 ec 18             	sub    $0x18,%esp
80103599:	8b 75 08             	mov    0x8(%ebp),%esi
8010359c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010359f:	56                   	push   %esi
801035a0:	e8 2b 0f 00 00       	call   801044d0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035a5:	83 c4 10             	add    $0x10,%esp
801035a8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035ae:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035b4:	75 6a                	jne    80103620 <piperead+0x90>
801035b6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801035bc:	85 db                	test   %ebx,%ebx
801035be:	0f 84 c4 00 00 00    	je     80103688 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801035c4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801035ca:	eb 2d                	jmp    801035f9 <piperead+0x69>
801035cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035d0:	83 ec 08             	sub    $0x8,%esp
801035d3:	56                   	push   %esi
801035d4:	53                   	push   %ebx
801035d5:	e8 a6 08 00 00       	call   80103e80 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035da:	83 c4 10             	add    $0x10,%esp
801035dd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035e3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035e9:	75 35                	jne    80103620 <piperead+0x90>
801035eb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801035f1:	85 d2                	test   %edx,%edx
801035f3:	0f 84 8f 00 00 00    	je     80103688 <piperead+0xf8>
    if(myproc()->killed){
801035f9:	e8 d2 02 00 00       	call   801038d0 <myproc>
801035fe:	8b 48 24             	mov    0x24(%eax),%ecx
80103601:	85 c9                	test   %ecx,%ecx
80103603:	74 cb                	je     801035d0 <piperead+0x40>
      release(&p->lock);
80103605:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103608:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
8010360d:	56                   	push   %esi
8010360e:	e8 dd 0f 00 00       	call   801045f0 <release>
      return -1;
80103613:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103616:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103619:	89 d8                	mov    %ebx,%eax
8010361b:	5b                   	pop    %ebx
8010361c:	5e                   	pop    %esi
8010361d:	5f                   	pop    %edi
8010361e:	5d                   	pop    %ebp
8010361f:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103620:	8b 45 10             	mov    0x10(%ebp),%eax
80103623:	85 c0                	test   %eax,%eax
80103625:	7e 61                	jle    80103688 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103627:	31 db                	xor    %ebx,%ebx
80103629:	eb 13                	jmp    8010363e <piperead+0xae>
8010362b:	90                   	nop
8010362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103630:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103636:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010363c:	74 1f                	je     8010365d <piperead+0xcd>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010363e:	8d 41 01             	lea    0x1(%ecx),%eax
80103641:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103647:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010364d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103652:	88 04 1f             	mov    %al,(%edi,%ebx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103655:	83 c3 01             	add    $0x1,%ebx
80103658:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010365b:	75 d3                	jne    80103630 <piperead+0xa0>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010365d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103663:	83 ec 0c             	sub    $0xc,%esp
80103666:	50                   	push   %eax
80103667:	e8 d4 09 00 00       	call   80104040 <wakeup>
  release(&p->lock);
8010366c:	89 34 24             	mov    %esi,(%esp)
8010366f:	e8 7c 0f 00 00       	call   801045f0 <release>
  return i;
80103674:	83 c4 10             	add    $0x10,%esp
}
80103677:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010367a:	89 d8                	mov    %ebx,%eax
8010367c:	5b                   	pop    %ebx
8010367d:	5e                   	pop    %esi
8010367e:	5f                   	pop    %edi
8010367f:	5d                   	pop    %ebp
80103680:	c3                   	ret    
80103681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
80103688:	31 db                	xor    %ebx,%ebx
8010368a:	eb d1                	jmp    8010365d <piperead+0xcd>
8010368c:	66 90                	xchg   %ax,%ax
8010368e:	66 90                	xchg   %ax,%ax

80103690 <allocproc>:
// state required to run in the kernel.
// Otherwise return 0.

static struct proc*
allocproc(void)
{
80103690:	55                   	push   %ebp
80103691:	89 e5                	mov    %esp,%ebp
80103693:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103694:	bb 54 35 11 80       	mov    $0x80113554,%ebx
// state required to run in the kernel.
// Otherwise return 0.

static struct proc*
allocproc(void)
{
80103699:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010369c:	68 20 35 11 80       	push   $0x80113520
801036a1:	e8 2a 0e 00 00       	call   801044d0 <acquire>
801036a6:	83 c4 10             	add    $0x10,%esp
801036a9:	eb 14                	jmp    801036bf <allocproc+0x2f>
801036ab:	90                   	nop
801036ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036b0:	83 c3 7c             	add    $0x7c,%ebx
801036b3:	81 fb 54 54 11 80    	cmp    $0x80115454,%ebx
801036b9:	0f 83 d9 00 00 00    	jae    80103798 <allocproc+0x108>
   if(p->state == UNUSED)
801036bf:	8b 43 0c             	mov    0xc(%ebx),%eax
801036c2:	85 c0                	test   %eax,%eax
801036c4:	75 ea                	jne    801036b0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801036c6:	8b 15 08 a0 10 80    	mov    0x8010a008,%edx
  //pstat.pid[pstat.n++]=nextpid;
  pstat.inuse[p-ptable.proc]=1;
  pstat.pid[p-ptable.proc]=p->pid;
  pstat.name[p-ptable.proc][0]=p->name[0];
801036cc:	0f b6 4b 6c          	movzbl 0x6c(%ebx),%ecx
      pstat.name[p-ptable.proc][1]=p->name[1];
          pstat.name[p-ptable.proc][2]=p->name[2];
  pstat.hticks[p-ptable.proc]= 0;
  pstat.lticks[p-ptable.proc]= 0;

  release(&ptable.lock);
801036d0:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801036d3:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801036da:	8d 42 01             	lea    0x1(%edx),%eax
801036dd:	89 53 10             	mov    %edx,0x10(%ebx)
801036e0:	a3 08 a0 10 80       	mov    %eax,0x8010a008
  //pstat.pid[pstat.n++]=nextpid;
  pstat.inuse[p-ptable.proc]=1;
801036e5:	89 d8                	mov    %ebx,%eax
801036e7:	2d 54 35 11 80       	sub    $0x80113554,%eax
801036ec:	c1 f8 02             	sar    $0x2,%eax
801036ef:	69 c0 df 7b ef bd    	imul   $0xbdef7bdf,%eax,%eax
  pstat.pid[p-ptable.proc]=p->pid;
801036f5:	89 14 85 20 2e 11 80 	mov    %edx,-0x7feed1e0(,%eax,4)
  pstat.name[p-ptable.proc][0]=p->name[0];
801036fc:	89 c2                	mov    %eax,%edx

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
  //pstat.pid[pstat.n++]=nextpid;
  pstat.inuse[p-ptable.proc]=1;
801036fe:	c7 04 85 20 2d 11 80 	movl   $0x1,-0x7feed2e0(,%eax,4)
80103705:	01 00 00 00 
  pstat.pid[p-ptable.proc]=p->pid;
  pstat.name[p-ptable.proc][0]=p->name[0];
80103709:	c1 e2 04             	shl    $0x4,%edx
      pstat.name[p-ptable.proc][1]=p->name[1];
          pstat.name[p-ptable.proc][2]=p->name[2];
  pstat.hticks[p-ptable.proc]= 0;
8010370c:	c7 04 85 20 33 11 80 	movl   $0x0,-0x7feecce0(,%eax,4)
80103713:	00 00 00 00 
  pstat.lticks[p-ptable.proc]= 0;
80103717:	c7 04 85 20 34 11 80 	movl   $0x0,-0x7feecbe0(,%eax,4)
8010371e:	00 00 00 00 
  p->state = EMBRYO;
  p->pid = nextpid++;
  //pstat.pid[pstat.n++]=nextpid;
  pstat.inuse[p-ptable.proc]=1;
  pstat.pid[p-ptable.proc]=p->pid;
  pstat.name[p-ptable.proc][0]=p->name[0];
80103722:	88 8a 20 2f 11 80    	mov    %cl,-0x7feed0e0(%edx)
      pstat.name[p-ptable.proc][1]=p->name[1];
80103728:	0f b6 4b 6d          	movzbl 0x6d(%ebx),%ecx
8010372c:	89 c2                	mov    %eax,%edx
8010372e:	c1 e2 04             	shl    $0x4,%edx
80103731:	88 8a 21 2f 11 80    	mov    %cl,-0x7feed0df(%edx)
          pstat.name[p-ptable.proc][2]=p->name[2];
80103737:	0f b6 4b 6e          	movzbl 0x6e(%ebx),%ecx
  pstat.hticks[p-ptable.proc]= 0;
  pstat.lticks[p-ptable.proc]= 0;

  release(&ptable.lock);
8010373b:	68 20 35 11 80       	push   $0x80113520
  //pstat.pid[pstat.n++]=nextpid;
  pstat.inuse[p-ptable.proc]=1;
  pstat.pid[p-ptable.proc]=p->pid;
  pstat.name[p-ptable.proc][0]=p->name[0];
      pstat.name[p-ptable.proc][1]=p->name[1];
          pstat.name[p-ptable.proc][2]=p->name[2];
80103740:	88 8a 22 2f 11 80    	mov    %cl,-0x7feed0de(%edx)
  pstat.hticks[p-ptable.proc]= 0;
  pstat.lticks[p-ptable.proc]= 0;

  release(&ptable.lock);
80103746:	e8 a5 0e 00 00       	call   801045f0 <release>


  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010374b:	e8 40 ed ff ff       	call   80102490 <kalloc>
80103750:	83 c4 10             	add    $0x10,%esp
80103753:	85 c0                	test   %eax,%eax
80103755:	89 43 08             	mov    %eax,0x8(%ebx)
80103758:	74 57                	je     801037b1 <allocproc+0x121>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010375a:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103760:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103763:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103768:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010376b:	c7 40 14 76 59 10 80 	movl   $0x80105976,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103772:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103775:	6a 14                	push   $0x14
80103777:	6a 00                	push   $0x0
80103779:	50                   	push   %eax
8010377a:	e8 c1 0e 00 00       	call   80104640 <memset>
  p->context->eip = (uint)forkret;
8010377f:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103782:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103785:	c7 40 10 c0 37 10 80 	movl   $0x801037c0,0x10(%eax)

  return p;
}
8010378c:	89 d8                	mov    %ebx,%eax
8010378e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103791:	c9                   	leave  
80103792:	c3                   	ret    
80103793:	90                   	nop
80103794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
   if(p->state == UNUSED)
     goto found;

  release(&ptable.lock);
80103798:	83 ec 0c             	sub    $0xc,%esp
  return 0;
8010379b:	31 db                	xor    %ebx,%ebx

 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
   if(p->state == UNUSED)
     goto found;

  release(&ptable.lock);
8010379d:	68 20 35 11 80       	push   $0x80113520
801037a2:	e8 49 0e 00 00       	call   801045f0 <release>
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
801037a7:	89 d8                	mov    %ebx,%eax
 for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
   if(p->state == UNUSED)
     goto found;

  release(&ptable.lock);
  return 0;
801037a9:	83 c4 10             	add    $0x10,%esp
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
801037ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037af:	c9                   	leave  
801037b0:	c3                   	ret    
  release(&ptable.lock);


  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801037b1:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801037b8:	31 db                	xor    %ebx,%ebx
801037ba:	eb d0                	jmp    8010378c <allocproc+0xfc>
801037bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801037c6:	68 20 35 11 80       	push   $0x80113520
801037cb:	e8 20 0e 00 00       	call   801045f0 <release>

  if (first) {
801037d0:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801037d5:	83 c4 10             	add    $0x10,%esp
801037d8:	85 c0                	test   %eax,%eax
801037da:	75 04                	jne    801037e0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037dc:	c9                   	leave  
801037dd:	c3                   	ret    
801037de:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801037e0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801037e3:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
801037ea:	00 00 00 
    iinit(ROOTDEV);
801037ed:	6a 01                	push   $0x1
801037ef:	e8 7c dc ff ff       	call   80101470 <iinit>
    initlog(ROOTDEV);
801037f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037fb:	e8 d0 f2 ff ff       	call   80102ad0 <initlog>
80103800:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103803:	c9                   	leave  
80103804:	c3                   	ret    
80103805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103810 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103816:	68 1d 77 10 80       	push   $0x8010771d
8010381b:	68 20 35 11 80       	push   $0x80113520
80103820:	e8 ab 0b 00 00       	call   801043d0 <initlock>
}
80103825:	83 c4 10             	add    $0x10,%esp
80103828:	c9                   	leave  
80103829:	c3                   	ret    
8010382a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103830 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being rescheduled
// between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	56                   	push   %esi
80103834:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103835:	9c                   	pushf  
80103836:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103837:	f6 c4 02             	test   $0x2,%ah
8010383a:	75 5e                	jne    8010389a <mycpu+0x6a>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010383c:	e8 bf ee ff ff       	call   80102700 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103841:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103847:	85 f6                	test   %esi,%esi
80103849:	7e 42                	jle    8010388d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010384b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103852:	39 d0                	cmp    %edx,%eax
80103854:	74 30                	je     80103886 <mycpu+0x56>
80103856:	b9 30 28 11 80       	mov    $0x80112830,%ecx
8010385b:	31 d2                	xor    %edx,%edx
8010385d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103860:	83 c2 01             	add    $0x1,%edx
80103863:	39 f2                	cmp    %esi,%edx
80103865:	74 26                	je     8010388d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103867:	0f b6 19             	movzbl (%ecx),%ebx
8010386a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103870:	39 d8                	cmp    %ebx,%eax
80103872:	75 ec                	jne    80103860 <mycpu+0x30>
80103874:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010387a:	05 80 27 11 80       	add    $0x80112780,%eax
      return &cpus[i];
  }
  panic("unknown apicid\n");
}
8010387f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103882:	5b                   	pop    %ebx
80103883:	5e                   	pop    %esi
80103884:	5d                   	pop    %ebp
80103885:	c3                   	ret    
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
80103886:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
8010388b:	eb f2                	jmp    8010387f <mycpu+0x4f>
  }
  panic("unknown apicid\n");
8010388d:	83 ec 0c             	sub    $0xc,%esp
80103890:	68 24 77 10 80       	push   $0x80107724
80103895:	e8 d6 ca ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
8010389a:	83 ec 0c             	sub    $0xc,%esp
8010389d:	68 60 78 10 80       	push   $0x80107860
801038a2:	e8 c9 ca ff ff       	call   80100370 <panic>
801038a7:	89 f6                	mov    %esi,%esi
801038a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038b0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801038b6:	e8 75 ff ff ff       	call   80103830 <mycpu>
801038bb:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
801038c0:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801038c1:	c1 f8 04             	sar    $0x4,%eax
801038c4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801038ca:	c3                   	ret    
801038cb:	90                   	nop
801038cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038d0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	53                   	push   %ebx
801038d4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801038d7:	e8 b4 0b 00 00       	call   80104490 <pushcli>
  c = mycpu();
801038dc:	e8 4f ff ff ff       	call   80103830 <mycpu>
  p = c->proc;
801038e1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038e7:	e8 94 0c 00 00       	call   80104580 <popcli>
  return p;
}
801038ec:	83 c4 04             	add    $0x4,%esp
801038ef:	89 d8                	mov    %ebx,%eax
801038f1:	5b                   	pop    %ebx
801038f2:	5d                   	pop    %ebp
801038f3:	c3                   	ret    
801038f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103900 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	53                   	push   %ebx
80103904:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103907:	e8 84 fd ff ff       	call   80103690 <allocproc>
8010390c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010390e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
80103913:	e8 48 36 00 00       	call   80106f60 <setupkvm>
80103918:	85 c0                	test   %eax,%eax
8010391a:	89 43 04             	mov    %eax,0x4(%ebx)
8010391d:	0f 84 bd 00 00 00    	je     801039e0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103923:	83 ec 04             	sub    $0x4,%esp
80103926:	68 2c 00 00 00       	push   $0x2c
8010392b:	68 60 a4 10 80       	push   $0x8010a460
80103930:	50                   	push   %eax
80103931:	e8 4a 33 00 00       	call   80106c80 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103936:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103939:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010393f:	6a 4c                	push   $0x4c
80103941:	6a 00                	push   $0x0
80103943:	ff 73 18             	pushl  0x18(%ebx)
80103946:	e8 f5 0c 00 00       	call   80104640 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010394b:	8b 43 18             	mov    0x18(%ebx),%eax
8010394e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103953:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103958:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010395b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010395f:	8b 43 18             	mov    0x18(%ebx),%eax
80103962:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103966:	8b 43 18             	mov    0x18(%ebx),%eax
80103969:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010396d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103971:	8b 43 18             	mov    0x18(%ebx),%eax
80103974:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103978:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010397c:	8b 43 18             	mov    0x18(%ebx),%eax
8010397f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103986:	8b 43 18             	mov    0x18(%ebx),%eax
80103989:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103990:	8b 43 18             	mov    0x18(%ebx),%eax
80103993:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010399a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010399d:	6a 10                	push   $0x10
8010399f:	68 4d 77 10 80       	push   $0x8010774d
801039a4:	50                   	push   %eax
801039a5:	e8 76 0e 00 00       	call   80104820 <safestrcpy>
  p->cwd = namei("/");
801039aa:	c7 04 24 56 77 10 80 	movl   $0x80107756,(%esp)
801039b1:	e8 ea e4 ff ff       	call   80101ea0 <namei>
801039b6:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801039b9:	c7 04 24 20 35 11 80 	movl   $0x80113520,(%esp)
801039c0:	e8 0b 0b 00 00       	call   801044d0 <acquire>

  p->state = RUNNABLE;
801039c5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801039cc:	c7 04 24 20 35 11 80 	movl   $0x80113520,(%esp)
801039d3:	e8 18 0c 00 00       	call   801045f0 <release>
}
801039d8:	83 c4 10             	add    $0x10,%esp
801039db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039de:	c9                   	leave  
801039df:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801039e0:	83 ec 0c             	sub    $0xc,%esp
801039e3:	68 34 77 10 80       	push   $0x80107734
801039e8:	e8 83 c9 ff ff       	call   80100370 <panic>
801039ed:	8d 76 00             	lea    0x0(%esi),%esi

801039f0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	56                   	push   %esi
801039f4:	53                   	push   %ebx
801039f5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801039f8:	e8 93 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
801039fd:	e8 2e fe ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103a02:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a08:	e8 73 0b 00 00       	call   80104580 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103a0d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103a10:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a12:	7e 34                	jle    80103a48 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a14:	83 ec 04             	sub    $0x4,%esp
80103a17:	01 c6                	add    %eax,%esi
80103a19:	56                   	push   %esi
80103a1a:	50                   	push   %eax
80103a1b:	ff 73 04             	pushl  0x4(%ebx)
80103a1e:	e8 9d 33 00 00       	call   80106dc0 <allocuvm>
80103a23:	83 c4 10             	add    $0x10,%esp
80103a26:	85 c0                	test   %eax,%eax
80103a28:	74 36                	je     80103a60 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103a2a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103a2d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a2f:	53                   	push   %ebx
80103a30:	e8 3b 31 00 00       	call   80106b70 <switchuvm>
  return 0;
80103a35:	83 c4 10             	add    $0x10,%esp
80103a38:	31 c0                	xor    %eax,%eax
}
80103a3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a3d:	5b                   	pop    %ebx
80103a3e:	5e                   	pop    %esi
80103a3f:	5d                   	pop    %ebp
80103a40:	c3                   	ret    
80103a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103a48:	74 e0                	je     80103a2a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a4a:	83 ec 04             	sub    $0x4,%esp
80103a4d:	01 c6                	add    %eax,%esi
80103a4f:	56                   	push   %esi
80103a50:	50                   	push   %eax
80103a51:	ff 73 04             	pushl  0x4(%ebx)
80103a54:	e8 57 34 00 00       	call   80106eb0 <deallocuvm>
80103a59:	83 c4 10             	add    $0x10,%esp
80103a5c:	85 c0                	test   %eax,%eax
80103a5e:	75 ca                	jne    80103a2a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103a60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a65:	eb d3                	jmp    80103a3a <growproc+0x4a>
80103a67:	89 f6                	mov    %esi,%esi
80103a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a70 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	57                   	push   %edi
80103a74:	56                   	push   %esi
80103a75:	53                   	push   %ebx
80103a76:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103a79:	e8 12 0a 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103a7e:	e8 ad fd ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103a83:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a89:	e8 f2 0a 00 00       	call   80104580 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103a8e:	e8 fd fb ff ff       	call   80103690 <allocproc>
80103a93:	85 c0                	test   %eax,%eax
80103a95:	89 c7                	mov    %eax,%edi
80103a97:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a9a:	0f 84 b5 00 00 00    	je     80103b55 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103aa0:	83 ec 08             	sub    $0x8,%esp
80103aa3:	ff 33                	pushl  (%ebx)
80103aa5:	ff 73 04             	pushl  0x4(%ebx)
80103aa8:	e8 83 35 00 00       	call   80107030 <copyuvm>
80103aad:	83 c4 10             	add    $0x10,%esp
80103ab0:	85 c0                	test   %eax,%eax
80103ab2:	89 47 04             	mov    %eax,0x4(%edi)
80103ab5:	0f 84 a1 00 00 00    	je     80103b5c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103abb:	8b 03                	mov    (%ebx),%eax
80103abd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ac0:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103ac2:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103ac5:	89 c8                	mov    %ecx,%eax
80103ac7:	8b 79 18             	mov    0x18(%ecx),%edi
80103aca:	8b 73 18             	mov    0x18(%ebx),%esi
80103acd:	b9 13 00 00 00       	mov    $0x13,%ecx
80103ad2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103ad4:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103ad6:	8b 40 18             	mov    0x18(%eax),%eax
80103ad9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103ae0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ae4:	85 c0                	test   %eax,%eax
80103ae6:	74 13                	je     80103afb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ae8:	83 ec 0c             	sub    $0xc,%esp
80103aeb:	50                   	push   %eax
80103aec:	e8 df d2 ff ff       	call   80100dd0 <filedup>
80103af1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103af4:	83 c4 10             	add    $0x10,%esp
80103af7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103afb:	83 c6 01             	add    $0x1,%esi
80103afe:	83 fe 10             	cmp    $0x10,%esi
80103b01:	75 dd                	jne    80103ae0 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b03:	83 ec 0c             	sub    $0xc,%esp
80103b06:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b09:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b0c:	e8 2f db ff ff       	call   80101640 <idup>
80103b11:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b14:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b17:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b1a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b1d:	6a 10                	push   $0x10
80103b1f:	53                   	push   %ebx
80103b20:	50                   	push   %eax
80103b21:	e8 fa 0c 00 00       	call   80104820 <safestrcpy>

  pid = np->pid;
80103b26:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103b29:	c7 04 24 20 35 11 80 	movl   $0x80113520,(%esp)
80103b30:	e8 9b 09 00 00       	call   801044d0 <acquire>

  np->state = RUNNABLE;
80103b35:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103b3c:	c7 04 24 20 35 11 80 	movl   $0x80113520,(%esp)
80103b43:	e8 a8 0a 00 00       	call   801045f0 <release>

  return pid;
80103b48:	83 c4 10             	add    $0x10,%esp
}
80103b4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b4e:	89 d8                	mov    %ebx,%eax
80103b50:	5b                   	pop    %ebx
80103b51:	5e                   	pop    %esi
80103b52:	5f                   	pop    %edi
80103b53:	5d                   	pop    %ebp
80103b54:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103b55:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b5a:	eb ef                	jmp    80103b4b <fork+0xdb>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103b5c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103b5f:	83 ec 0c             	sub    $0xc,%esp
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
80103b62:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103b67:	ff 77 08             	pushl  0x8(%edi)
80103b6a:	e8 71 e7 ff ff       	call   801022e0 <kfree>
    np->kstack = 0;
80103b6f:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103b76:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103b7d:	83 c4 10             	add    $0x10,%esp
80103b80:	eb c9                	jmp    80103b4b <fork+0xdb>
80103b82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b90 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	57                   	push   %edi
80103b94:	56                   	push   %esi
80103b95:	53                   	push   %ebx
80103b96:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103b99:	e8 92 fc ff ff       	call   80103830 <mycpu>
80103b9e:	8d 78 04             	lea    0x4(%eax),%edi
80103ba1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103ba3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103baa:	00 00 00 
80103bad:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103bb0:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103bb1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bb4:	bb 54 35 11 80       	mov    $0x80113554,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103bb9:	68 20 35 11 80       	push   $0x80113520
80103bbe:	e8 0d 09 00 00       	call   801044d0 <acquire>
80103bc3:	83 c4 10             	add    $0x10,%esp
80103bc6:	eb 13                	jmp    80103bdb <scheduler+0x4b>
80103bc8:	90                   	nop
80103bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bd0:	83 c3 7c             	add    $0x7c,%ebx
80103bd3:	81 fb 54 54 11 80    	cmp    $0x80115454,%ebx
80103bd9:	73 45                	jae    80103c20 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103bdb:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103bdf:	75 ef                	jne    80103bd0 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103be1:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103be4:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103bea:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103beb:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103bee:	e8 7d 2f 00 00       	call   80106b70 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103bf3:	58                   	pop    %eax
80103bf4:	5a                   	pop    %edx
80103bf5:	ff 73 a0             	pushl  -0x60(%ebx)
80103bf8:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103bf9:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80103c00:	e8 76 0c 00 00       	call   8010487b <swtch>
      switchkvm();
80103c05:	e8 46 2f 00 00       	call   80106b50 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103c0a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c0d:	81 fb 54 54 11 80    	cmp    $0x80115454,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103c13:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c1a:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c1d:	72 bc                	jb     80103bdb <scheduler+0x4b>
80103c1f:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103c20:	83 ec 0c             	sub    $0xc,%esp
80103c23:	68 20 35 11 80       	push   $0x80113520
80103c28:	e8 c3 09 00 00       	call   801045f0 <release>
  struct cpu *c = mycpu();
  c->proc = 0;
  
  for(;;){
    // Enable interrupts on this processor.
    sti();
80103c2d:	83 c4 10             	add    $0x10,%esp
80103c30:	e9 7b ff ff ff       	jmp    80103bb0 <scheduler+0x20>
80103c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c40 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	56                   	push   %esi
80103c44:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c45:	e8 46 08 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103c4a:	e8 e1 fb ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103c4f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c55:	e8 26 09 00 00       	call   80104580 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103c5a:	83 ec 0c             	sub    $0xc,%esp
80103c5d:	68 20 35 11 80       	push   $0x80113520
80103c62:	e8 e9 07 00 00       	call   80104450 <holding>
80103c67:	83 c4 10             	add    $0x10,%esp
80103c6a:	85 c0                	test   %eax,%eax
80103c6c:	74 4f                	je     80103cbd <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103c6e:	e8 bd fb ff ff       	call   80103830 <mycpu>
80103c73:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c7a:	75 68                	jne    80103ce4 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103c7c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c80:	74 55                	je     80103cd7 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c82:	9c                   	pushf  
80103c83:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103c84:	f6 c4 02             	test   $0x2,%ah
80103c87:	75 41                	jne    80103cca <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103c89:	e8 a2 fb ff ff       	call   80103830 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c8e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103c91:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c97:	e8 94 fb ff ff       	call   80103830 <mycpu>
80103c9c:	83 ec 08             	sub    $0x8,%esp
80103c9f:	ff 70 04             	pushl  0x4(%eax)
80103ca2:	53                   	push   %ebx
80103ca3:	e8 d3 0b 00 00       	call   8010487b <swtch>
  mycpu()->intena = intena;
80103ca8:	e8 83 fb ff ff       	call   80103830 <mycpu>
}
80103cad:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103cb0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103cb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cb9:	5b                   	pop    %ebx
80103cba:	5e                   	pop    %esi
80103cbb:	5d                   	pop    %ebp
80103cbc:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103cbd:	83 ec 0c             	sub    $0xc,%esp
80103cc0:	68 58 77 10 80       	push   $0x80107758
80103cc5:	e8 a6 c6 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103cca:	83 ec 0c             	sub    $0xc,%esp
80103ccd:	68 84 77 10 80       	push   $0x80107784
80103cd2:	e8 99 c6 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103cd7:	83 ec 0c             	sub    $0xc,%esp
80103cda:	68 76 77 10 80       	push   $0x80107776
80103cdf:	e8 8c c6 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103ce4:	83 ec 0c             	sub    $0xc,%esp
80103ce7:	68 6a 77 10 80       	push   $0x8010776a
80103cec:	e8 7f c6 ff ff       	call   80100370 <panic>
80103cf1:	eb 0d                	jmp    80103d00 <exit>
80103cf3:	90                   	nop
80103cf4:	90                   	nop
80103cf5:	90                   	nop
80103cf6:	90                   	nop
80103cf7:	90                   	nop
80103cf8:	90                   	nop
80103cf9:	90                   	nop
80103cfa:	90                   	nop
80103cfb:	90                   	nop
80103cfc:	90                   	nop
80103cfd:	90                   	nop
80103cfe:	90                   	nop
80103cff:	90                   	nop

80103d00 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	57                   	push   %edi
80103d04:	56                   	push   %esi
80103d05:	53                   	push   %ebx
80103d06:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d09:	e8 82 07 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103d0e:	e8 1d fb ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103d13:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d19:	e8 62 08 00 00       	call   80104580 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103d1e:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103d24:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d27:	8d 7e 68             	lea    0x68(%esi),%edi
80103d2a:	0f 84 e7 00 00 00    	je     80103e17 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103d30:	8b 03                	mov    (%ebx),%eax
80103d32:	85 c0                	test   %eax,%eax
80103d34:	74 12                	je     80103d48 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d36:	83 ec 0c             	sub    $0xc,%esp
80103d39:	50                   	push   %eax
80103d3a:	e8 e1 d0 ff ff       	call   80100e20 <fileclose>
      curproc->ofile[fd] = 0;
80103d3f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d45:	83 c4 10             	add    $0x10,%esp
80103d48:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103d4b:	39 fb                	cmp    %edi,%ebx
80103d4d:	75 e1                	jne    80103d30 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103d4f:	e8 1c ee ff ff       	call   80102b70 <begin_op>
  iput(curproc->cwd);
80103d54:	83 ec 0c             	sub    $0xc,%esp
80103d57:	ff 76 68             	pushl  0x68(%esi)
80103d5a:	e8 41 da ff ff       	call   801017a0 <iput>
  end_op();
80103d5f:	e8 7c ee ff ff       	call   80102be0 <end_op>
  curproc->cwd = 0;
80103d64:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103d6b:	c7 04 24 20 35 11 80 	movl   $0x80113520,(%esp)
80103d72:	e8 59 07 00 00       	call   801044d0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103d77:	8b 56 14             	mov    0x14(%esi),%edx
80103d7a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d7d:	b8 54 35 11 80       	mov    $0x80113554,%eax
80103d82:	eb 0e                	jmp    80103d92 <exit+0x92>
80103d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d88:	83 c0 7c             	add    $0x7c,%eax
80103d8b:	3d 54 54 11 80       	cmp    $0x80115454,%eax
80103d90:	73 1c                	jae    80103dae <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103d92:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d96:	75 f0                	jne    80103d88 <exit+0x88>
80103d98:	3b 50 20             	cmp    0x20(%eax),%edx
80103d9b:	75 eb                	jne    80103d88 <exit+0x88>
      p->state = RUNNABLE;
80103d9d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da4:	83 c0 7c             	add    $0x7c,%eax
80103da7:	3d 54 54 11 80       	cmp    $0x80115454,%eax
80103dac:	72 e4                	jb     80103d92 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103dae:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
80103db4:	ba 54 35 11 80       	mov    $0x80113554,%edx
80103db9:	eb 10                	jmp    80103dcb <exit+0xcb>
80103dbb:	90                   	nop
80103dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103dc0:	83 c2 7c             	add    $0x7c,%edx
80103dc3:	81 fa 54 54 11 80    	cmp    $0x80115454,%edx
80103dc9:	73 33                	jae    80103dfe <exit+0xfe>
    if(p->parent == curproc){
80103dcb:	39 72 14             	cmp    %esi,0x14(%edx)
80103dce:	75 f0                	jne    80103dc0 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103dd0:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103dd4:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103dd7:	75 e7                	jne    80103dc0 <exit+0xc0>
80103dd9:	b8 54 35 11 80       	mov    $0x80113554,%eax
80103dde:	eb 0a                	jmp    80103dea <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103de0:	83 c0 7c             	add    $0x7c,%eax
80103de3:	3d 54 54 11 80       	cmp    $0x80115454,%eax
80103de8:	73 d6                	jae    80103dc0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103dea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dee:	75 f0                	jne    80103de0 <exit+0xe0>
80103df0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103df3:	75 eb                	jne    80103de0 <exit+0xe0>
      p->state = RUNNABLE;
80103df5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103dfc:	eb e2                	jmp    80103de0 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103dfe:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e05:	e8 36 fe ff ff       	call   80103c40 <sched>
  panic("zombie exit");
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 a5 77 10 80       	push   $0x801077a5
80103e12:	e8 59 c5 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103e17:	83 ec 0c             	sub    $0xc,%esp
80103e1a:	68 98 77 10 80       	push   $0x80107798
80103e1f:	e8 4c c5 ff ff       	call   80100370 <panic>
80103e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e30 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	53                   	push   %ebx
80103e34:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e37:	68 20 35 11 80       	push   $0x80113520
80103e3c:	e8 8f 06 00 00       	call   801044d0 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e41:	e8 4a 06 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103e46:	e8 e5 f9 ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103e4b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e51:	e8 2a 07 00 00       	call   80104580 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103e56:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e5d:	e8 de fd ff ff       	call   80103c40 <sched>
  release(&ptable.lock);
80103e62:	c7 04 24 20 35 11 80 	movl   $0x80113520,(%esp)
80103e69:	e8 82 07 00 00       	call   801045f0 <release>
}
80103e6e:	83 c4 10             	add    $0x10,%esp
80103e71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e74:	c9                   	leave  
80103e75:	c3                   	ret    
80103e76:	8d 76 00             	lea    0x0(%esi),%esi
80103e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e80 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	57                   	push   %edi
80103e84:	56                   	push   %esi
80103e85:	53                   	push   %ebx
80103e86:	83 ec 0c             	sub    $0xc,%esp
80103e89:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e8c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e8f:	e8 fc 05 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103e94:	e8 97 f9 ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103e99:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e9f:	e8 dc 06 00 00       	call   80104580 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103ea4:	85 db                	test   %ebx,%ebx
80103ea6:	0f 84 87 00 00 00    	je     80103f33 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103eac:	85 f6                	test   %esi,%esi
80103eae:	74 76                	je     80103f26 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103eb0:	81 fe 20 35 11 80    	cmp    $0x80113520,%esi
80103eb6:	74 50                	je     80103f08 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103eb8:	83 ec 0c             	sub    $0xc,%esp
80103ebb:	68 20 35 11 80       	push   $0x80113520
80103ec0:	e8 0b 06 00 00       	call   801044d0 <acquire>
    release(lk);
80103ec5:	89 34 24             	mov    %esi,(%esp)
80103ec8:	e8 23 07 00 00       	call   801045f0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103ecd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ed0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103ed7:	e8 64 fd ff ff       	call   80103c40 <sched>

  // Tidy up.
  p->chan = 0;
80103edc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103ee3:	c7 04 24 20 35 11 80 	movl   $0x80113520,(%esp)
80103eea:	e8 01 07 00 00       	call   801045f0 <release>
    acquire(lk);
80103eef:	89 75 08             	mov    %esi,0x8(%ebp)
80103ef2:	83 c4 10             	add    $0x10,%esp
  }
}
80103ef5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ef8:	5b                   	pop    %ebx
80103ef9:	5e                   	pop    %esi
80103efa:	5f                   	pop    %edi
80103efb:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103efc:	e9 cf 05 00 00       	jmp    801044d0 <acquire>
80103f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103f08:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f0b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103f12:	e8 29 fd ff ff       	call   80103c40 <sched>

  // Tidy up.
  p->chan = 0;
80103f17:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103f1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f21:	5b                   	pop    %ebx
80103f22:	5e                   	pop    %esi
80103f23:	5f                   	pop    %edi
80103f24:	5d                   	pop    %ebp
80103f25:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103f26:	83 ec 0c             	sub    $0xc,%esp
80103f29:	68 b7 77 10 80       	push   $0x801077b7
80103f2e:	e8 3d c4 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103f33:	83 ec 0c             	sub    $0xc,%esp
80103f36:	68 b1 77 10 80       	push   $0x801077b1
80103f3b:	e8 30 c4 ff ff       	call   80100370 <panic>

80103f40 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	56                   	push   %esi
80103f44:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f45:	e8 46 05 00 00       	call   80104490 <pushcli>
  c = mycpu();
80103f4a:	e8 e1 f8 ff ff       	call   80103830 <mycpu>
  p = c->proc;
80103f4f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f55:	e8 26 06 00 00       	call   80104580 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80103f5a:	83 ec 0c             	sub    $0xc,%esp
80103f5d:	68 20 35 11 80       	push   $0x80113520
80103f62:	e8 69 05 00 00       	call   801044d0 <acquire>
80103f67:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103f6a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f6c:	bb 54 35 11 80       	mov    $0x80113554,%ebx
80103f71:	eb 10                	jmp    80103f83 <wait+0x43>
80103f73:	90                   	nop
80103f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f78:	83 c3 7c             	add    $0x7c,%ebx
80103f7b:	81 fb 54 54 11 80    	cmp    $0x80115454,%ebx
80103f81:	73 1d                	jae    80103fa0 <wait+0x60>
      if(p->parent != curproc)
80103f83:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f86:	75 f0                	jne    80103f78 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103f88:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f8c:	74 30                	je     80103fbe <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f8e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103f91:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f96:	81 fb 54 54 11 80    	cmp    $0x80115454,%ebx
80103f9c:	72 e5                	jb     80103f83 <wait+0x43>
80103f9e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103fa0:	85 c0                	test   %eax,%eax
80103fa2:	74 70                	je     80104014 <wait+0xd4>
80103fa4:	8b 46 24             	mov    0x24(%esi),%eax
80103fa7:	85 c0                	test   %eax,%eax
80103fa9:	75 69                	jne    80104014 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103fab:	83 ec 08             	sub    $0x8,%esp
80103fae:	68 20 35 11 80       	push   $0x80113520
80103fb3:	56                   	push   %esi
80103fb4:	e8 c7 fe ff ff       	call   80103e80 <sleep>
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103fb9:	83 c4 10             	add    $0x10,%esp
80103fbc:	eb ac                	jmp    80103f6a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103fbe:	83 ec 0c             	sub    $0xc,%esp
80103fc1:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103fc4:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fc7:	e8 14 e3 ff ff       	call   801022e0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103fcc:	5a                   	pop    %edx
80103fcd:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103fd0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fd7:	e8 04 2f 00 00       	call   80106ee0 <freevm>
        p->pid = 0;
80103fdc:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fe3:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fea:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fee:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103ff5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103ffc:	c7 04 24 20 35 11 80 	movl   $0x80113520,(%esp)
80104003:	e8 e8 05 00 00       	call   801045f0 <release>
        return pid;
80104008:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010400b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010400e:	89 f0                	mov    %esi,%eax
80104010:	5b                   	pop    %ebx
80104011:	5e                   	pop    %esi
80104012:	5d                   	pop    %ebp
80104013:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104014:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104017:	be ff ff ff ff       	mov    $0xffffffff,%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
8010401c:	68 20 35 11 80       	push   $0x80113520
80104021:	e8 ca 05 00 00       	call   801045f0 <release>
      return -1;
80104026:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104029:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010402c:	89 f0                	mov    %esi,%eax
8010402e:	5b                   	pop    %ebx
8010402f:	5e                   	pop    %esi
80104030:	5d                   	pop    %ebp
80104031:	c3                   	ret    
80104032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104040 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	53                   	push   %ebx
80104044:	83 ec 10             	sub    $0x10,%esp
80104047:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010404a:	68 20 35 11 80       	push   $0x80113520
8010404f:	e8 7c 04 00 00       	call   801044d0 <acquire>
80104054:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104057:	b8 54 35 11 80       	mov    $0x80113554,%eax
8010405c:	eb 0c                	jmp    8010406a <wakeup+0x2a>
8010405e:	66 90                	xchg   %ax,%ax
80104060:	83 c0 7c             	add    $0x7c,%eax
80104063:	3d 54 54 11 80       	cmp    $0x80115454,%eax
80104068:	73 1c                	jae    80104086 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010406a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010406e:	75 f0                	jne    80104060 <wakeup+0x20>
80104070:	3b 58 20             	cmp    0x20(%eax),%ebx
80104073:	75 eb                	jne    80104060 <wakeup+0x20>
      p->state = RUNNABLE;
80104075:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010407c:	83 c0 7c             	add    $0x7c,%eax
8010407f:	3d 54 54 11 80       	cmp    $0x80115454,%eax
80104084:	72 e4                	jb     8010406a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104086:	c7 45 08 20 35 11 80 	movl   $0x80113520,0x8(%ebp)
}
8010408d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104090:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104091:	e9 5a 05 00 00       	jmp    801045f0 <release>
80104096:	8d 76 00             	lea    0x0(%esi),%esi
80104099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	53                   	push   %ebx
801040a4:	83 ec 10             	sub    $0x10,%esp
801040a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801040aa:	68 20 35 11 80       	push   $0x80113520
801040af:	e8 1c 04 00 00       	call   801044d0 <acquire>
801040b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040b7:	b8 54 35 11 80       	mov    $0x80113554,%eax
801040bc:	eb 0c                	jmp    801040ca <kill+0x2a>
801040be:	66 90                	xchg   %ax,%ax
801040c0:	83 c0 7c             	add    $0x7c,%eax
801040c3:	3d 54 54 11 80       	cmp    $0x80115454,%eax
801040c8:	73 3e                	jae    80104108 <kill+0x68>
    if(p->pid == pid){
801040ca:	39 58 10             	cmp    %ebx,0x10(%eax)
801040cd:	75 f1                	jne    801040c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040cf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
801040d3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040da:	74 1c                	je     801040f8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
801040dc:	83 ec 0c             	sub    $0xc,%esp
801040df:	68 20 35 11 80       	push   $0x80113520
801040e4:	e8 07 05 00 00       	call   801045f0 <release>
      return 0;
801040e9:	83 c4 10             	add    $0x10,%esp
801040ec:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040f1:	c9                   	leave  
801040f2:	c3                   	ret    
801040f3:	90                   	nop
801040f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
801040f8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040ff:	eb db                	jmp    801040dc <kill+0x3c>
80104101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104108:	83 ec 0c             	sub    $0xc,%esp
8010410b:	68 20 35 11 80       	push   $0x80113520
80104110:	e8 db 04 00 00       	call   801045f0 <release>
  return -1;
80104115:	83 c4 10             	add    $0x10,%esp
80104118:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010411d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104120:	c9                   	leave  
80104121:	c3                   	ret    
80104122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104130 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	57                   	push   %edi
80104134:	56                   	push   %esi
80104135:	53                   	push   %ebx
80104136:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104139:	bb 54 35 11 80       	mov    $0x80113554,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
8010413e:	83 ec 3c             	sub    $0x3c,%esp
80104141:	eb 24                	jmp    80104167 <procdump+0x37>
80104143:	90                   	nop
80104144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104148:	83 ec 0c             	sub    $0xc,%esp
8010414b:	68 ea 77 10 80       	push   $0x801077ea
80104150:	e8 0b c5 ff ff       	call   80100660 <cprintf>
80104155:	83 c4 10             	add    $0x10,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104158:	83 c3 7c             	add    $0x7c,%ebx
8010415b:	81 fb 54 54 11 80    	cmp    $0x80115454,%ebx
80104161:	0f 83 81 00 00 00    	jae    801041e8 <procdump+0xb8>
    if(p->state == UNUSED)
80104167:	8b 43 0c             	mov    0xc(%ebx),%eax
8010416a:	85 c0                	test   %eax,%eax
8010416c:	74 ea                	je     80104158 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010416e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104171:	ba c8 77 10 80       	mov    $0x801077c8,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104176:	77 11                	ja     80104189 <procdump+0x59>
80104178:	8b 14 85 88 78 10 80 	mov    -0x7fef8778(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010417f:	b8 c8 77 10 80       	mov    $0x801077c8,%eax
80104184:	85 d2                	test   %edx,%edx
80104186:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104189:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010418c:	50                   	push   %eax
8010418d:	52                   	push   %edx
8010418e:	ff 73 10             	pushl  0x10(%ebx)
80104191:	68 cc 77 10 80       	push   $0x801077cc
80104196:	e8 c5 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010419b:	83 c4 10             	add    $0x10,%esp
8010419e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
801041a2:	75 a4                	jne    80104148 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041a4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041a7:	83 ec 08             	sub    $0x8,%esp
801041aa:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041ad:	50                   	push   %eax
801041ae:	8b 43 1c             	mov    0x1c(%ebx),%eax
801041b1:	8b 40 0c             	mov    0xc(%eax),%eax
801041b4:	83 c0 08             	add    $0x8,%eax
801041b7:	50                   	push   %eax
801041b8:	e8 33 02 00 00       	call   801043f0 <getcallerpcs>
801041bd:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801041c0:	8b 17                	mov    (%edi),%edx
801041c2:	85 d2                	test   %edx,%edx
801041c4:	74 82                	je     80104148 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041c6:	83 ec 08             	sub    $0x8,%esp
801041c9:	83 c7 04             	add    $0x4,%edi
801041cc:	52                   	push   %edx
801041cd:	68 41 72 10 80       	push   $0x80107241
801041d2:	e8 89 c4 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801041d7:	83 c4 10             	add    $0x10,%esp
801041da:	39 fe                	cmp    %edi,%esi
801041dc:	75 e2                	jne    801041c0 <procdump+0x90>
801041de:	e9 65 ff ff ff       	jmp    80104148 <procdump+0x18>
801041e3:	90                   	nop
801041e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801041e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041eb:	5b                   	pop    %ebx
801041ec:	5e                   	pop    %esi
801041ed:	5f                   	pop    %edi
801041ee:	5d                   	pop    %ebp
801041ef:	c3                   	ret    

801041f0 <cps>:

//current process status
int
cps()
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	53                   	push   %ebx
801041f4:	83 ec 10             	sub    $0x10,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
801041f7:	fb                   	sti    
   struct proc *p;

   //enable interrupts on this processor.
   sti();
     //loop over process table lookng for process with pid.
   acquire(&ptable.lock);
801041f8:	68 20 35 11 80       	push   $0x80113520
801041fd:	bb c0 35 11 80       	mov    $0x801135c0,%ebx
80104202:	e8 c9 02 00 00       	call   801044d0 <acquire>
   cprintf("name \t pid \t state \t \n");
80104207:	c7 04 24 d5 77 10 80 	movl   $0x801077d5,(%esp)
8010420e:	e8 4d c4 ff ff       	call   80100660 <cprintf>
80104213:	83 c4 10             	add    $0x10,%esp
80104216:	eb 22                	jmp    8010423a <cps+0x4a>
80104218:	90                   	nop
80104219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
   for(p = ptable.proc; p<&ptable.proc[NPROC]; p++){
      if ( p->state==SLEEPING )
         cprintf("%s \t %d \t SLEEPING \t \n ",p->name,p->pid);
      else if (p->state==RUNNING)
80104220:	83 f8 04             	cmp    $0x4,%eax
80104223:	74 5b                	je     80104280 <cps+0x90>
         cprintf("%s \t %d \t RUNNING \t \n ",p->name,p->pid);
      else if (p->state==RUNNABLE)
80104225:	83 f8 03             	cmp    $0x3,%eax
80104228:	74 76                	je     801042a0 <cps+0xb0>
8010422a:	8d 43 7c             	lea    0x7c(%ebx),%eax
   //enable interrupts on this processor.
   sti();
     //loop over process table lookng for process with pid.
   acquire(&ptable.lock);
   cprintf("name \t pid \t state \t \n");
   for(p = ptable.proc; p<&ptable.proc[NPROC]; p++){
8010422d:	83 c3 10             	add    $0x10,%ebx
80104230:	81 fb 54 54 11 80    	cmp    $0x80115454,%ebx
80104236:	73 2c                	jae    80104264 <cps+0x74>
80104238:	89 c3                	mov    %eax,%ebx
      if ( p->state==SLEEPING )
8010423a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010423d:	83 f8 02             	cmp    $0x2,%eax
80104240:	75 de                	jne    80104220 <cps+0x30>
         cprintf("%s \t %d \t SLEEPING \t \n ",p->name,p->pid);
80104242:	83 ec 04             	sub    $0x4,%esp
80104245:	ff 73 a4             	pushl  -0x5c(%ebx)
80104248:	53                   	push   %ebx
80104249:	68 ec 77 10 80       	push   $0x801077ec
8010424e:	e8 0d c4 ff ff       	call   80100660 <cprintf>
80104253:	8d 43 7c             	lea    0x7c(%ebx),%eax
   //enable interrupts on this processor.
   sti();
     //loop over process table lookng for process with pid.
   acquire(&ptable.lock);
   cprintf("name \t pid \t state \t \n");
   for(p = ptable.proc; p<&ptable.proc[NPROC]; p++){
80104256:	83 c3 10             	add    $0x10,%ebx
80104259:	83 c4 10             	add    $0x10,%esp
8010425c:	81 fb 54 54 11 80    	cmp    $0x80115454,%ebx
80104262:	72 d4                	jb     80104238 <cps+0x48>
         cprintf("%s \t %d \t RUNNING \t \n ",p->name,p->pid);
      else if (p->state==RUNNABLE)
         cprintf("%s \t %d \t RUNNABLE \t \n ",p->name,p->pid);
   }

   release(&ptable.lock);
80104264:	83 ec 0c             	sub    $0xc,%esp
80104267:	68 20 35 11 80       	push   $0x80113520
8010426c:	e8 7f 03 00 00       	call   801045f0 <release>
   return 22;
}
80104271:	b8 16 00 00 00       	mov    $0x16,%eax
80104276:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104279:	c9                   	leave  
8010427a:	c3                   	ret    
8010427b:	90                   	nop
8010427c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
   cprintf("name \t pid \t state \t \n");
   for(p = ptable.proc; p<&ptable.proc[NPROC]; p++){
      if ( p->state==SLEEPING )
         cprintf("%s \t %d \t SLEEPING \t \n ",p->name,p->pid);
      else if (p->state==RUNNING)
         cprintf("%s \t %d \t RUNNING \t \n ",p->name,p->pid);
80104280:	83 ec 04             	sub    $0x4,%esp
80104283:	ff 73 a4             	pushl  -0x5c(%ebx)
80104286:	53                   	push   %ebx
80104287:	68 04 78 10 80       	push   $0x80107804
8010428c:	e8 cf c3 ff ff       	call   80100660 <cprintf>
80104291:	83 c4 10             	add    $0x10,%esp
80104294:	eb 94                	jmp    8010422a <cps+0x3a>
80104296:	8d 76 00             	lea    0x0(%esi),%esi
80104299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      else if (p->state==RUNNABLE)
         cprintf("%s \t %d \t RUNNABLE \t \n ",p->name,p->pid);
801042a0:	83 ec 04             	sub    $0x4,%esp
801042a3:	ff 73 a4             	pushl  -0x5c(%ebx)
801042a6:	53                   	push   %ebx
801042a7:	68 1b 78 10 80       	push   $0x8010781b
801042ac:	e8 af c3 ff ff       	call   80100660 <cprintf>
801042b1:	83 c4 10             	add    $0x10,%esp
801042b4:	e9 71 ff ff ff       	jmp    8010422a <cps+0x3a>
801042b9:	66 90                	xchg   %ax,%ax
801042bb:	66 90                	xchg   %ax,%ax
801042bd:	66 90                	xchg   %ax,%ax
801042bf:	90                   	nop

801042c0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	53                   	push   %ebx
801042c4:	83 ec 0c             	sub    $0xc,%esp
801042c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801042ca:	68 a0 78 10 80       	push   $0x801078a0
801042cf:	8d 43 04             	lea    0x4(%ebx),%eax
801042d2:	50                   	push   %eax
801042d3:	e8 f8 00 00 00       	call   801043d0 <initlock>
  lk->name = name;
801042d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801042db:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801042e1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801042e4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801042eb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801042ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042f1:	c9                   	leave  
801042f2:	c3                   	ret    
801042f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801042f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104300 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	56                   	push   %esi
80104304:	53                   	push   %ebx
80104305:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104308:	83 ec 0c             	sub    $0xc,%esp
8010430b:	8d 73 04             	lea    0x4(%ebx),%esi
8010430e:	56                   	push   %esi
8010430f:	e8 bc 01 00 00       	call   801044d0 <acquire>
  while (lk->locked) {
80104314:	8b 13                	mov    (%ebx),%edx
80104316:	83 c4 10             	add    $0x10,%esp
80104319:	85 d2                	test   %edx,%edx
8010431b:	74 16                	je     80104333 <acquiresleep+0x33>
8010431d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104320:	83 ec 08             	sub    $0x8,%esp
80104323:	56                   	push   %esi
80104324:	53                   	push   %ebx
80104325:	e8 56 fb ff ff       	call   80103e80 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010432a:	8b 03                	mov    (%ebx),%eax
8010432c:	83 c4 10             	add    $0x10,%esp
8010432f:	85 c0                	test   %eax,%eax
80104331:	75 ed                	jne    80104320 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104333:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104339:	e8 92 f5 ff ff       	call   801038d0 <myproc>
8010433e:	8b 40 10             	mov    0x10(%eax),%eax
80104341:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104344:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104347:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010434a:	5b                   	pop    %ebx
8010434b:	5e                   	pop    %esi
8010434c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010434d:	e9 9e 02 00 00       	jmp    801045f0 <release>
80104352:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104360 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	56                   	push   %esi
80104364:	53                   	push   %ebx
80104365:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104368:	83 ec 0c             	sub    $0xc,%esp
8010436b:	8d 73 04             	lea    0x4(%ebx),%esi
8010436e:	56                   	push   %esi
8010436f:	e8 5c 01 00 00       	call   801044d0 <acquire>
  lk->locked = 0;
80104374:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010437a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104381:	89 1c 24             	mov    %ebx,(%esp)
80104384:	e8 b7 fc ff ff       	call   80104040 <wakeup>
  release(&lk->lk);
80104389:	89 75 08             	mov    %esi,0x8(%ebp)
8010438c:	83 c4 10             	add    $0x10,%esp
}
8010438f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104392:	5b                   	pop    %ebx
80104393:	5e                   	pop    %esi
80104394:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104395:	e9 56 02 00 00       	jmp    801045f0 <release>
8010439a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043a0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	56                   	push   %esi
801043a4:	53                   	push   %ebx
801043a5:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
801043a8:	83 ec 0c             	sub    $0xc,%esp
801043ab:	8d 5e 04             	lea    0x4(%esi),%ebx
801043ae:	53                   	push   %ebx
801043af:	e8 1c 01 00 00       	call   801044d0 <acquire>
  r = lk->locked;
801043b4:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
801043b6:	89 1c 24             	mov    %ebx,(%esp)
801043b9:	e8 32 02 00 00       	call   801045f0 <release>
  return r;
}
801043be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043c1:	89 f0                	mov    %esi,%eax
801043c3:	5b                   	pop    %ebx
801043c4:	5e                   	pop    %esi
801043c5:	5d                   	pop    %ebp
801043c6:	c3                   	ret    
801043c7:	66 90                	xchg   %ax,%ax
801043c9:	66 90                	xchg   %ax,%ax
801043cb:	66 90                	xchg   %ax,%ax
801043cd:	66 90                	xchg   %ax,%ax
801043cf:	90                   	nop

801043d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801043d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801043d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801043df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801043e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801043e9:	5d                   	pop    %ebp
801043ea:	c3                   	ret    
801043eb:	90                   	nop
801043ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043f4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043fa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801043fd:	31 c0                	xor    %eax,%eax
801043ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104400:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104406:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010440c:	77 1a                	ja     80104428 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010440e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104411:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104414:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104417:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104419:	83 f8 0a             	cmp    $0xa,%eax
8010441c:	75 e2                	jne    80104400 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010441e:	5b                   	pop    %ebx
8010441f:	5d                   	pop    %ebp
80104420:	c3                   	ret    
80104421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104428:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010442f:	83 c0 01             	add    $0x1,%eax
80104432:	83 f8 0a             	cmp    $0xa,%eax
80104435:	74 e7                	je     8010441e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104437:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010443e:	83 c0 01             	add    $0x1,%eax
80104441:	83 f8 0a             	cmp    $0xa,%eax
80104444:	75 e2                	jne    80104428 <getcallerpcs+0x38>
80104446:	eb d6                	jmp    8010441e <getcallerpcs+0x2e>
80104448:	90                   	nop
80104449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104450 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	53                   	push   %ebx
80104454:	83 ec 04             	sub    $0x4,%esp
80104457:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010445a:	8b 02                	mov    (%edx),%eax
8010445c:	85 c0                	test   %eax,%eax
8010445e:	75 10                	jne    80104470 <holding+0x20>
}
80104460:	83 c4 04             	add    $0x4,%esp
80104463:	31 c0                	xor    %eax,%eax
80104465:	5b                   	pop    %ebx
80104466:	5d                   	pop    %ebp
80104467:	c3                   	ret    
80104468:	90                   	nop
80104469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104470:	8b 5a 08             	mov    0x8(%edx),%ebx
80104473:	e8 b8 f3 ff ff       	call   80103830 <mycpu>
80104478:	39 c3                	cmp    %eax,%ebx
8010447a:	0f 94 c0             	sete   %al
}
8010447d:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104480:	0f b6 c0             	movzbl %al,%eax
}
80104483:	5b                   	pop    %ebx
80104484:	5d                   	pop    %ebp
80104485:	c3                   	ret    
80104486:	8d 76 00             	lea    0x0(%esi),%esi
80104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104490 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	53                   	push   %ebx
80104494:	83 ec 04             	sub    $0x4,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104497:	9c                   	pushf  
80104498:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104499:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010449a:	e8 91 f3 ff ff       	call   80103830 <mycpu>
8010449f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801044a5:	85 c0                	test   %eax,%eax
801044a7:	75 11                	jne    801044ba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801044a9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801044af:	e8 7c f3 ff ff       	call   80103830 <mycpu>
801044b4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801044ba:	e8 71 f3 ff ff       	call   80103830 <mycpu>
801044bf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801044c6:	83 c4 04             	add    $0x4,%esp
801044c9:	5b                   	pop    %ebx
801044ca:	5d                   	pop    %ebp
801044cb:	c3                   	ret    
801044cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044d0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	56                   	push   %esi
801044d4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801044d5:	e8 b6 ff ff ff       	call   80104490 <pushcli>
  if(holding(lk))
801044da:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801044dd:	8b 03                	mov    (%ebx),%eax
801044df:	85 c0                	test   %eax,%eax
801044e1:	75 7d                	jne    80104560 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801044e3:	ba 01 00 00 00       	mov    $0x1,%edx
801044e8:	eb 09                	jmp    801044f3 <acquire+0x23>
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044f0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044f3:	89 d0                	mov    %edx,%eax
801044f5:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801044f8:	85 c0                	test   %eax,%eax
801044fa:	75 f4                	jne    801044f0 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801044fc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104501:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104504:	e8 27 f3 ff ff       	call   80103830 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104509:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010450b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010450e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104511:	31 c0                	xor    %eax,%eax
80104513:	90                   	nop
80104514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104518:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010451e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104524:	77 1a                	ja     80104540 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104526:	8b 5a 04             	mov    0x4(%edx),%ebx
80104529:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010452c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010452f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104531:	83 f8 0a             	cmp    $0xa,%eax
80104534:	75 e2                	jne    80104518 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80104536:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104539:	5b                   	pop    %ebx
8010453a:	5e                   	pop    %esi
8010453b:	5d                   	pop    %ebp
8010453c:	c3                   	ret    
8010453d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104540:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104547:	83 c0 01             	add    $0x1,%eax
8010454a:	83 f8 0a             	cmp    $0xa,%eax
8010454d:	74 e7                	je     80104536 <acquire+0x66>
    pcs[i] = 0;
8010454f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104556:	83 c0 01             	add    $0x1,%eax
80104559:	83 f8 0a             	cmp    $0xa,%eax
8010455c:	75 e2                	jne    80104540 <acquire+0x70>
8010455e:	eb d6                	jmp    80104536 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104560:	8b 73 08             	mov    0x8(%ebx),%esi
80104563:	e8 c8 f2 ff ff       	call   80103830 <mycpu>
80104568:	39 c6                	cmp    %eax,%esi
8010456a:	0f 85 73 ff ff ff    	jne    801044e3 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104570:	83 ec 0c             	sub    $0xc,%esp
80104573:	68 ab 78 10 80       	push   $0x801078ab
80104578:	e8 f3 bd ff ff       	call   80100370 <panic>
8010457d:	8d 76 00             	lea    0x0(%esi),%esi

80104580 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104586:	9c                   	pushf  
80104587:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104588:	f6 c4 02             	test   $0x2,%ah
8010458b:	75 52                	jne    801045df <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010458d:	e8 9e f2 ff ff       	call   80103830 <mycpu>
80104592:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104598:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010459b:	85 d2                	test   %edx,%edx
8010459d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801045a3:	78 2d                	js     801045d2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045a5:	e8 86 f2 ff ff       	call   80103830 <mycpu>
801045aa:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801045b0:	85 d2                	test   %edx,%edx
801045b2:	74 0c                	je     801045c0 <popcli+0x40>
    sti();
}
801045b4:	c9                   	leave  
801045b5:	c3                   	ret    
801045b6:	8d 76 00             	lea    0x0(%esi),%esi
801045b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045c0:	e8 6b f2 ff ff       	call   80103830 <mycpu>
801045c5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801045cb:	85 c0                	test   %eax,%eax
801045cd:	74 e5                	je     801045b4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801045cf:	fb                   	sti    
    sti();
}
801045d0:	c9                   	leave  
801045d1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801045d2:	83 ec 0c             	sub    $0xc,%esp
801045d5:	68 ca 78 10 80       	push   $0x801078ca
801045da:	e8 91 bd ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801045df:	83 ec 0c             	sub    $0xc,%esp
801045e2:	68 b3 78 10 80       	push   $0x801078b3
801045e7:	e8 84 bd ff ff       	call   80100370 <panic>
801045ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045f0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
801045f5:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801045f8:	8b 03                	mov    (%ebx),%eax
801045fa:	85 c0                	test   %eax,%eax
801045fc:	75 12                	jne    80104610 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801045fe:	83 ec 0c             	sub    $0xc,%esp
80104601:	68 d1 78 10 80       	push   $0x801078d1
80104606:	e8 65 bd ff ff       	call   80100370 <panic>
8010460b:	90                   	nop
8010460c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80104610:	8b 73 08             	mov    0x8(%ebx),%esi
80104613:	e8 18 f2 ff ff       	call   80103830 <mycpu>
80104618:	39 c6                	cmp    %eax,%esi
8010461a:	75 e2                	jne    801045fe <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
8010461c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104623:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010462a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010462f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104635:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104638:	5b                   	pop    %ebx
80104639:	5e                   	pop    %esi
8010463a:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010463b:	e9 40 ff ff ff       	jmp    80104580 <popcli>

80104640 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	57                   	push   %edi
80104644:	53                   	push   %ebx
80104645:	8b 55 08             	mov    0x8(%ebp),%edx
80104648:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010464b:	f6 c2 03             	test   $0x3,%dl
8010464e:	75 05                	jne    80104655 <memset+0x15>
80104650:	f6 c1 03             	test   $0x3,%cl
80104653:	74 13                	je     80104668 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104655:	89 d7                	mov    %edx,%edi
80104657:	8b 45 0c             	mov    0xc(%ebp),%eax
8010465a:	fc                   	cld    
8010465b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010465d:	5b                   	pop    %ebx
8010465e:	89 d0                	mov    %edx,%eax
80104660:	5f                   	pop    %edi
80104661:	5d                   	pop    %ebp
80104662:	c3                   	ret    
80104663:	90                   	nop
80104664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104668:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010466c:	c1 e9 02             	shr    $0x2,%ecx
8010466f:	89 f8                	mov    %edi,%eax
80104671:	89 fb                	mov    %edi,%ebx
80104673:	c1 e0 18             	shl    $0x18,%eax
80104676:	c1 e3 10             	shl    $0x10,%ebx
80104679:	09 d8                	or     %ebx,%eax
8010467b:	09 f8                	or     %edi,%eax
8010467d:	c1 e7 08             	shl    $0x8,%edi
80104680:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80104682:	89 d7                	mov    %edx,%edi
80104684:	fc                   	cld    
80104685:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104687:	5b                   	pop    %ebx
80104688:	89 d0                	mov    %edx,%eax
8010468a:	5f                   	pop    %edi
8010468b:	5d                   	pop    %ebp
8010468c:	c3                   	ret    
8010468d:	8d 76 00             	lea    0x0(%esi),%esi

80104690 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	57                   	push   %edi
80104694:	56                   	push   %esi
80104695:	53                   	push   %ebx
80104696:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104699:	8b 75 08             	mov    0x8(%ebp),%esi
8010469c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010469f:	85 db                	test   %ebx,%ebx
801046a1:	74 29                	je     801046cc <memcmp+0x3c>
    if(*s1 != *s2)
801046a3:	0f b6 16             	movzbl (%esi),%edx
801046a6:	0f b6 0f             	movzbl (%edi),%ecx
801046a9:	38 d1                	cmp    %dl,%cl
801046ab:	75 2b                	jne    801046d8 <memcmp+0x48>
801046ad:	b8 01 00 00 00       	mov    $0x1,%eax
801046b2:	eb 14                	jmp    801046c8 <memcmp+0x38>
801046b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046b8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801046bc:	83 c0 01             	add    $0x1,%eax
801046bf:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
801046c4:	38 ca                	cmp    %cl,%dl
801046c6:	75 10                	jne    801046d8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801046c8:	39 d8                	cmp    %ebx,%eax
801046ca:	75 ec                	jne    801046b8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801046cc:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
801046cd:	31 c0                	xor    %eax,%eax
}
801046cf:	5e                   	pop    %esi
801046d0:	5f                   	pop    %edi
801046d1:	5d                   	pop    %ebp
801046d2:	c3                   	ret    
801046d3:	90                   	nop
801046d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801046d8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
801046db:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801046dc:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801046de:	5e                   	pop    %esi
801046df:	5f                   	pop    %edi
801046e0:	5d                   	pop    %ebp
801046e1:	c3                   	ret    
801046e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046f0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
801046f5:	8b 45 08             	mov    0x8(%ebp),%eax
801046f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046fb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801046fe:	39 c3                	cmp    %eax,%ebx
80104700:	73 26                	jae    80104728 <memmove+0x38>
80104702:	8d 14 33             	lea    (%ebx,%esi,1),%edx
80104705:	39 d0                	cmp    %edx,%eax
80104707:	73 1f                	jae    80104728 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104709:	85 f6                	test   %esi,%esi
8010470b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010470e:	74 0f                	je     8010471f <memmove+0x2f>
      *--d = *--s;
80104710:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104714:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104717:	83 ea 01             	sub    $0x1,%edx
8010471a:	83 fa ff             	cmp    $0xffffffff,%edx
8010471d:	75 f1                	jne    80104710 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010471f:	5b                   	pop    %ebx
80104720:	5e                   	pop    %esi
80104721:	5d                   	pop    %ebp
80104722:	c3                   	ret    
80104723:	90                   	nop
80104724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104728:	31 d2                	xor    %edx,%edx
8010472a:	85 f6                	test   %esi,%esi
8010472c:	74 f1                	je     8010471f <memmove+0x2f>
8010472e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104730:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104734:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104737:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010473a:	39 f2                	cmp    %esi,%edx
8010473c:	75 f2                	jne    80104730 <memmove+0x40>
      *d++ = *s++;

  return dst;
}
8010473e:	5b                   	pop    %ebx
8010473f:	5e                   	pop    %esi
80104740:	5d                   	pop    %ebp
80104741:	c3                   	ret    
80104742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104750 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104753:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104754:	eb 9a                	jmp    801046f0 <memmove>
80104756:	8d 76 00             	lea    0x0(%esi),%esi
80104759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104760 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	57                   	push   %edi
80104764:	56                   	push   %esi
80104765:	8b 7d 10             	mov    0x10(%ebp),%edi
80104768:	53                   	push   %ebx
80104769:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010476c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010476f:	85 ff                	test   %edi,%edi
80104771:	74 2f                	je     801047a2 <strncmp+0x42>
80104773:	0f b6 11             	movzbl (%ecx),%edx
80104776:	0f b6 1e             	movzbl (%esi),%ebx
80104779:	84 d2                	test   %dl,%dl
8010477b:	74 37                	je     801047b4 <strncmp+0x54>
8010477d:	38 d3                	cmp    %dl,%bl
8010477f:	75 33                	jne    801047b4 <strncmp+0x54>
80104781:	01 f7                	add    %esi,%edi
80104783:	eb 13                	jmp    80104798 <strncmp+0x38>
80104785:	8d 76 00             	lea    0x0(%esi),%esi
80104788:	0f b6 11             	movzbl (%ecx),%edx
8010478b:	84 d2                	test   %dl,%dl
8010478d:	74 21                	je     801047b0 <strncmp+0x50>
8010478f:	0f b6 18             	movzbl (%eax),%ebx
80104792:	89 c6                	mov    %eax,%esi
80104794:	38 da                	cmp    %bl,%dl
80104796:	75 1c                	jne    801047b4 <strncmp+0x54>
    n--, p++, q++;
80104798:	8d 46 01             	lea    0x1(%esi),%eax
8010479b:	83 c1 01             	add    $0x1,%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010479e:	39 f8                	cmp    %edi,%eax
801047a0:	75 e6                	jne    80104788 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801047a2:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
801047a3:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
801047a5:	5e                   	pop    %esi
801047a6:	5f                   	pop    %edi
801047a7:	5d                   	pop    %ebp
801047a8:	c3                   	ret    
801047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047b0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801047b4:	0f b6 c2             	movzbl %dl,%eax
801047b7:	29 d8                	sub    %ebx,%eax
}
801047b9:	5b                   	pop    %ebx
801047ba:	5e                   	pop    %esi
801047bb:	5f                   	pop    %edi
801047bc:	5d                   	pop    %ebp
801047bd:	c3                   	ret    
801047be:	66 90                	xchg   %ax,%ax

801047c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	53                   	push   %ebx
801047c5:	8b 45 08             	mov    0x8(%ebp),%eax
801047c8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801047cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801047ce:	89 c2                	mov    %eax,%edx
801047d0:	eb 19                	jmp    801047eb <strncpy+0x2b>
801047d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801047d8:	83 c3 01             	add    $0x1,%ebx
801047db:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801047df:	83 c2 01             	add    $0x1,%edx
801047e2:	84 c9                	test   %cl,%cl
801047e4:	88 4a ff             	mov    %cl,-0x1(%edx)
801047e7:	74 09                	je     801047f2 <strncpy+0x32>
801047e9:	89 f1                	mov    %esi,%ecx
801047eb:	85 c9                	test   %ecx,%ecx
801047ed:	8d 71 ff             	lea    -0x1(%ecx),%esi
801047f0:	7f e6                	jg     801047d8 <strncpy+0x18>
    ;
  while(n-- > 0)
801047f2:	31 c9                	xor    %ecx,%ecx
801047f4:	85 f6                	test   %esi,%esi
801047f6:	7e 17                	jle    8010480f <strncpy+0x4f>
801047f8:	90                   	nop
801047f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104800:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104804:	89 f3                	mov    %esi,%ebx
80104806:	83 c1 01             	add    $0x1,%ecx
80104809:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010480b:	85 db                	test   %ebx,%ebx
8010480d:	7f f1                	jg     80104800 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010480f:	5b                   	pop    %ebx
80104810:	5e                   	pop    %esi
80104811:	5d                   	pop    %ebp
80104812:	c3                   	ret    
80104813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	56                   	push   %esi
80104824:	53                   	push   %ebx
80104825:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104828:	8b 45 08             	mov    0x8(%ebp),%eax
8010482b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010482e:	85 c9                	test   %ecx,%ecx
80104830:	7e 26                	jle    80104858 <safestrcpy+0x38>
80104832:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104836:	89 c1                	mov    %eax,%ecx
80104838:	eb 17                	jmp    80104851 <safestrcpy+0x31>
8010483a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104840:	83 c2 01             	add    $0x1,%edx
80104843:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104847:	83 c1 01             	add    $0x1,%ecx
8010484a:	84 db                	test   %bl,%bl
8010484c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010484f:	74 04                	je     80104855 <safestrcpy+0x35>
80104851:	39 f2                	cmp    %esi,%edx
80104853:	75 eb                	jne    80104840 <safestrcpy+0x20>
    ;
  *s = 0;
80104855:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104858:	5b                   	pop    %ebx
80104859:	5e                   	pop    %esi
8010485a:	5d                   	pop    %ebp
8010485b:	c3                   	ret    
8010485c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104860 <strlen>:

int
strlen(const char *s)
{
80104860:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104861:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104863:	89 e5                	mov    %esp,%ebp
80104865:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104868:	80 3a 00             	cmpb   $0x0,(%edx)
8010486b:	74 0c                	je     80104879 <strlen+0x19>
8010486d:	8d 76 00             	lea    0x0(%esi),%esi
80104870:	83 c0 01             	add    $0x1,%eax
80104873:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104877:	75 f7                	jne    80104870 <strlen+0x10>
    ;
  return n;
}
80104879:	5d                   	pop    %ebp
8010487a:	c3                   	ret    

8010487b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010487b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010487f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104883:	55                   	push   %ebp
  pushl %ebx
80104884:	53                   	push   %ebx
  pushl %esi
80104885:	56                   	push   %esi
  pushl %edi
80104886:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104887:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104889:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010488b:	5f                   	pop    %edi
  popl %esi
8010488c:	5e                   	pop    %esi
  popl %ebx
8010488d:	5b                   	pop    %ebx
  popl %ebp
8010488e:	5d                   	pop    %ebp
  ret
8010488f:	c3                   	ret    

80104890 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
80104894:	83 ec 04             	sub    $0x4,%esp
80104897:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010489a:	e8 31 f0 ff ff       	call   801038d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010489f:	8b 00                	mov    (%eax),%eax
801048a1:	39 d8                	cmp    %ebx,%eax
801048a3:	76 1b                	jbe    801048c0 <fetchint+0x30>
801048a5:	8d 53 04             	lea    0x4(%ebx),%edx
801048a8:	39 d0                	cmp    %edx,%eax
801048aa:	72 14                	jb     801048c0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801048ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801048af:	8b 13                	mov    (%ebx),%edx
801048b1:	89 10                	mov    %edx,(%eax)
  return 0;
801048b3:	31 c0                	xor    %eax,%eax
}
801048b5:	83 c4 04             	add    $0x4,%esp
801048b8:	5b                   	pop    %ebx
801048b9:	5d                   	pop    %ebp
801048ba:	c3                   	ret    
801048bb:	90                   	nop
801048bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801048c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048c5:	eb ee                	jmp    801048b5 <fetchint+0x25>
801048c7:	89 f6                	mov    %esi,%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	53                   	push   %ebx
801048d4:	83 ec 04             	sub    $0x4,%esp
801048d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801048da:	e8 f1 ef ff ff       	call   801038d0 <myproc>

  if(addr >= curproc->sz)
801048df:	39 18                	cmp    %ebx,(%eax)
801048e1:	76 29                	jbe    8010490c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801048e3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801048e6:	89 da                	mov    %ebx,%edx
801048e8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801048ea:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801048ec:	39 c3                	cmp    %eax,%ebx
801048ee:	73 1c                	jae    8010490c <fetchstr+0x3c>
    if(*s == 0)
801048f0:	80 3b 00             	cmpb   $0x0,(%ebx)
801048f3:	75 10                	jne    80104905 <fetchstr+0x35>
801048f5:	eb 29                	jmp    80104920 <fetchstr+0x50>
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104900:	80 3a 00             	cmpb   $0x0,(%edx)
80104903:	74 1b                	je     80104920 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104905:	83 c2 01             	add    $0x1,%edx
80104908:	39 d0                	cmp    %edx,%eax
8010490a:	77 f4                	ja     80104900 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010490c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010490f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104914:	5b                   	pop    %ebx
80104915:	5d                   	pop    %ebp
80104916:	c3                   	ret    
80104917:	89 f6                	mov    %esi,%esi
80104919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104920:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104923:	89 d0                	mov    %edx,%eax
80104925:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104927:	5b                   	pop    %ebx
80104928:	5d                   	pop    %ebp
80104929:	c3                   	ret    
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104930 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104935:	e8 96 ef ff ff       	call   801038d0 <myproc>
8010493a:	8b 40 18             	mov    0x18(%eax),%eax
8010493d:	8b 55 08             	mov    0x8(%ebp),%edx
80104940:	8b 40 44             	mov    0x44(%eax),%eax
80104943:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104946:	e8 85 ef ff ff       	call   801038d0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010494b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010494d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104950:	39 c6                	cmp    %eax,%esi
80104952:	73 1c                	jae    80104970 <argint+0x40>
80104954:	8d 53 08             	lea    0x8(%ebx),%edx
80104957:	39 d0                	cmp    %edx,%eax
80104959:	72 15                	jb     80104970 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010495b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010495e:	8b 53 04             	mov    0x4(%ebx),%edx
80104961:	89 10                	mov    %edx,(%eax)
  return 0;
80104963:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104965:	5b                   	pop    %ebx
80104966:	5e                   	pop    %esi
80104967:	5d                   	pop    %ebp
80104968:	c3                   	ret    
80104969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104975:	eb ee                	jmp    80104965 <argint+0x35>
80104977:	89 f6                	mov    %esi,%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104980 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	56                   	push   %esi
80104984:	53                   	push   %ebx
80104985:	83 ec 10             	sub    $0x10,%esp
80104988:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010498b:	e8 40 ef ff ff       	call   801038d0 <myproc>
80104990:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104992:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104995:	83 ec 08             	sub    $0x8,%esp
80104998:	50                   	push   %eax
80104999:	ff 75 08             	pushl  0x8(%ebp)
8010499c:	e8 8f ff ff ff       	call   80104930 <argint>
801049a1:	c1 e8 1f             	shr    $0x1f,%eax
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801049a4:	83 c4 10             	add    $0x10,%esp
801049a7:	84 c0                	test   %al,%al
801049a9:	75 2d                	jne    801049d8 <argptr+0x58>
801049ab:	89 d8                	mov    %ebx,%eax
801049ad:	c1 e8 1f             	shr    $0x1f,%eax
801049b0:	84 c0                	test   %al,%al
801049b2:	75 24                	jne    801049d8 <argptr+0x58>
801049b4:	8b 16                	mov    (%esi),%edx
801049b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049b9:	39 c2                	cmp    %eax,%edx
801049bb:	76 1b                	jbe    801049d8 <argptr+0x58>
801049bd:	01 c3                	add    %eax,%ebx
801049bf:	39 da                	cmp    %ebx,%edx
801049c1:	72 15                	jb     801049d8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
801049c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801049c6:	89 02                	mov    %eax,(%edx)
  return 0;
801049c8:	31 c0                	xor    %eax,%eax
}
801049ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049cd:	5b                   	pop    %ebx
801049ce:	5e                   	pop    %esi
801049cf:	5d                   	pop    %ebp
801049d0:	c3                   	ret    
801049d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
801049d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049dd:	eb eb                	jmp    801049ca <argptr+0x4a>
801049df:	90                   	nop

801049e0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801049e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049e9:	50                   	push   %eax
801049ea:	ff 75 08             	pushl  0x8(%ebp)
801049ed:	e8 3e ff ff ff       	call   80104930 <argint>
801049f2:	83 c4 10             	add    $0x10,%esp
801049f5:	85 c0                	test   %eax,%eax
801049f7:	78 17                	js     80104a10 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801049f9:	83 ec 08             	sub    $0x8,%esp
801049fc:	ff 75 0c             	pushl  0xc(%ebp)
801049ff:	ff 75 f4             	pushl  -0xc(%ebp)
80104a02:	e8 c9 fe ff ff       	call   801048d0 <fetchstr>
80104a07:	83 c4 10             	add    $0x10,%esp
}
80104a0a:	c9                   	leave  
80104a0b:	c3                   	ret    
80104a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104a15:	c9                   	leave  
80104a16:	c3                   	ret    
80104a17:	89 f6                	mov    %esi,%esi
80104a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a20 <syscall>:
[SYS_cps]     sys_cps,
};

void
syscall(void)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	56                   	push   %esi
80104a24:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104a25:	e8 a6 ee ff ff       	call   801038d0 <myproc>

  num = curproc->tf->eax;
80104a2a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104a2d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104a2f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104a32:	8d 50 ff             	lea    -0x1(%eax),%edx
80104a35:	83 fa 18             	cmp    $0x18,%edx
80104a38:	77 1e                	ja     80104a58 <syscall+0x38>
80104a3a:	8b 14 85 00 79 10 80 	mov    -0x7fef8700(,%eax,4),%edx
80104a41:	85 d2                	test   %edx,%edx
80104a43:	74 13                	je     80104a58 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104a45:	ff d2                	call   *%edx
80104a47:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104a4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a4d:	5b                   	pop    %ebx
80104a4e:	5e                   	pop    %esi
80104a4f:	5d                   	pop    %ebp
80104a50:	c3                   	ret    
80104a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a58:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104a59:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104a5c:	50                   	push   %eax
80104a5d:	ff 73 10             	pushl  0x10(%ebx)
80104a60:	68 d9 78 10 80       	push   $0x801078d9
80104a65:	e8 f6 bb ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104a6a:	8b 43 18             	mov    0x18(%ebx),%eax
80104a6d:	83 c4 10             	add    $0x10,%esp
80104a70:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104a77:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a7a:	5b                   	pop    %ebx
80104a7b:	5e                   	pop    %esi
80104a7c:	5d                   	pop    %ebp
80104a7d:	c3                   	ret    
80104a7e:	66 90                	xchg   %ax,%ax

80104a80 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	57                   	push   %edi
80104a84:	56                   	push   %esi
80104a85:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a86:	8d 5d da             	lea    -0x26(%ebp),%ebx
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a89:	83 ec 44             	sub    $0x44,%esp
80104a8c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a8f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a92:	53                   	push   %ebx
80104a93:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a94:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a97:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a9a:	e8 21 d4 ff ff       	call   80101ec0 <nameiparent>
80104a9f:	83 c4 10             	add    $0x10,%esp
80104aa2:	85 c0                	test   %eax,%eax
80104aa4:	0f 84 f6 00 00 00    	je     80104ba0 <create+0x120>
    return 0;
  ilock(dp);
80104aaa:	83 ec 0c             	sub    $0xc,%esp
80104aad:	89 c6                	mov    %eax,%esi
80104aaf:	50                   	push   %eax
80104ab0:	e8 bb cb ff ff       	call   80101670 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104ab5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104ab8:	83 c4 0c             	add    $0xc,%esp
80104abb:	50                   	push   %eax
80104abc:	53                   	push   %ebx
80104abd:	56                   	push   %esi
80104abe:	e8 bd d0 ff ff       	call   80101b80 <dirlookup>
80104ac3:	83 c4 10             	add    $0x10,%esp
80104ac6:	85 c0                	test   %eax,%eax
80104ac8:	89 c7                	mov    %eax,%edi
80104aca:	74 54                	je     80104b20 <create+0xa0>
    iunlockput(dp);
80104acc:	83 ec 0c             	sub    $0xc,%esp
80104acf:	56                   	push   %esi
80104ad0:	e8 0b ce ff ff       	call   801018e0 <iunlockput>
    ilock(ip);
80104ad5:	89 3c 24             	mov    %edi,(%esp)
80104ad8:	e8 93 cb ff ff       	call   80101670 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104add:	83 c4 10             	add    $0x10,%esp
80104ae0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ae5:	75 19                	jne    80104b00 <create+0x80>
80104ae7:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104aec:	75 12                	jne    80104b00 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104aee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104af1:	89 f8                	mov    %edi,%eax
80104af3:	5b                   	pop    %ebx
80104af4:	5e                   	pop    %esi
80104af5:	5f                   	pop    %edi
80104af6:	5d                   	pop    %ebp
80104af7:	c3                   	ret    
80104af8:	90                   	nop
80104af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104b00:	83 ec 0c             	sub    $0xc,%esp
80104b03:	57                   	push   %edi
    return 0;
80104b04:	31 ff                	xor    %edi,%edi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104b06:	e8 d5 cd ff ff       	call   801018e0 <iunlockput>
    return 0;
80104b0b:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104b0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b11:	89 f8                	mov    %edi,%eax
80104b13:	5b                   	pop    %ebx
80104b14:	5e                   	pop    %esi
80104b15:	5f                   	pop    %edi
80104b16:	5d                   	pop    %ebp
80104b17:	c3                   	ret    
80104b18:	90                   	nop
80104b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104b20:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104b24:	83 ec 08             	sub    $0x8,%esp
80104b27:	50                   	push   %eax
80104b28:	ff 36                	pushl  (%esi)
80104b2a:	e8 d1 c9 ff ff       	call   80101500 <ialloc>
80104b2f:	83 c4 10             	add    $0x10,%esp
80104b32:	85 c0                	test   %eax,%eax
80104b34:	89 c7                	mov    %eax,%edi
80104b36:	0f 84 cc 00 00 00    	je     80104c08 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
80104b3c:	83 ec 0c             	sub    $0xc,%esp
80104b3f:	50                   	push   %eax
80104b40:	e8 2b cb ff ff       	call   80101670 <ilock>
  ip->major = major;
80104b45:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104b49:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104b4d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104b51:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104b55:	b8 01 00 00 00       	mov    $0x1,%eax
80104b5a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104b5e:	89 3c 24             	mov    %edi,(%esp)
80104b61:	e8 5a ca ff ff       	call   801015c0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104b66:	83 c4 10             	add    $0x10,%esp
80104b69:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b6e:	74 40                	je     80104bb0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104b70:	83 ec 04             	sub    $0x4,%esp
80104b73:	ff 77 04             	pushl  0x4(%edi)
80104b76:	53                   	push   %ebx
80104b77:	56                   	push   %esi
80104b78:	e8 63 d2 ff ff       	call   80101de0 <dirlink>
80104b7d:	83 c4 10             	add    $0x10,%esp
80104b80:	85 c0                	test   %eax,%eax
80104b82:	78 77                	js     80104bfb <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104b84:	83 ec 0c             	sub    $0xc,%esp
80104b87:	56                   	push   %esi
80104b88:	e8 53 cd ff ff       	call   801018e0 <iunlockput>

  return ip;
80104b8d:	83 c4 10             	add    $0x10,%esp
}
80104b90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b93:	89 f8                	mov    %edi,%eax
80104b95:	5b                   	pop    %ebx
80104b96:	5e                   	pop    %esi
80104b97:	5f                   	pop    %edi
80104b98:	5d                   	pop    %ebp
80104b99:	c3                   	ret    
80104b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104ba0:	31 ff                	xor    %edi,%edi
80104ba2:	e9 47 ff ff ff       	jmp    80104aee <create+0x6e>
80104ba7:	89 f6                	mov    %esi,%esi
80104ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104bb0:	66 83 46 56 01       	addw   $0x1,0x56(%esi)
    iupdate(dp);
80104bb5:	83 ec 0c             	sub    $0xc,%esp
80104bb8:	56                   	push   %esi
80104bb9:	e8 02 ca ff ff       	call   801015c0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104bbe:	83 c4 0c             	add    $0xc,%esp
80104bc1:	ff 77 04             	pushl  0x4(%edi)
80104bc4:	68 84 79 10 80       	push   $0x80107984
80104bc9:	57                   	push   %edi
80104bca:	e8 11 d2 ff ff       	call   80101de0 <dirlink>
80104bcf:	83 c4 10             	add    $0x10,%esp
80104bd2:	85 c0                	test   %eax,%eax
80104bd4:	78 18                	js     80104bee <create+0x16e>
80104bd6:	83 ec 04             	sub    $0x4,%esp
80104bd9:	ff 76 04             	pushl  0x4(%esi)
80104bdc:	68 83 79 10 80       	push   $0x80107983
80104be1:	57                   	push   %edi
80104be2:	e8 f9 d1 ff ff       	call   80101de0 <dirlink>
80104be7:	83 c4 10             	add    $0x10,%esp
80104bea:	85 c0                	test   %eax,%eax
80104bec:	79 82                	jns    80104b70 <create+0xf0>
      panic("create dots");
80104bee:	83 ec 0c             	sub    $0xc,%esp
80104bf1:	68 77 79 10 80       	push   $0x80107977
80104bf6:	e8 75 b7 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104bfb:	83 ec 0c             	sub    $0xc,%esp
80104bfe:	68 86 79 10 80       	push   $0x80107986
80104c03:	e8 68 b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104c08:	83 ec 0c             	sub    $0xc,%esp
80104c0b:	68 68 79 10 80       	push   $0x80107968
80104c10:	e8 5b b7 ff ff       	call   80100370 <panic>
80104c15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c20 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	56                   	push   %esi
80104c24:	53                   	push   %ebx
80104c25:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c27:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104c2a:	89 d3                	mov    %edx,%ebx
80104c2c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104c2f:	50                   	push   %eax
80104c30:	6a 00                	push   $0x0
80104c32:	e8 f9 fc ff ff       	call   80104930 <argint>
80104c37:	83 c4 10             	add    $0x10,%esp
80104c3a:	85 c0                	test   %eax,%eax
80104c3c:	78 32                	js     80104c70 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104c3e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104c42:	77 2c                	ja     80104c70 <argfd.constprop.0+0x50>
80104c44:	e8 87 ec ff ff       	call   801038d0 <myproc>
80104c49:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c4c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104c50:	85 c0                	test   %eax,%eax
80104c52:	74 1c                	je     80104c70 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104c54:	85 f6                	test   %esi,%esi
80104c56:	74 02                	je     80104c5a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104c58:	89 16                	mov    %edx,(%esi)
  if(pf)
80104c5a:	85 db                	test   %ebx,%ebx
80104c5c:	74 22                	je     80104c80 <argfd.constprop.0+0x60>
    *pf = f;
80104c5e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104c60:	31 c0                	xor    %eax,%eax
}
80104c62:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c65:	5b                   	pop    %ebx
80104c66:	5e                   	pop    %esi
80104c67:	5d                   	pop    %ebp
80104c68:	c3                   	ret    
80104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c70:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104c73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104c78:	5b                   	pop    %ebx
80104c79:	5e                   	pop    %esi
80104c7a:	5d                   	pop    %ebp
80104c7b:	c3                   	ret    
80104c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104c80:	31 c0                	xor    %eax,%eax
80104c82:	eb de                	jmp    80104c62 <argfd.constprop.0+0x42>
80104c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c90 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104c90:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c91:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104c93:	89 e5                	mov    %esp,%ebp
80104c95:	56                   	push   %esi
80104c96:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c97:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104c9a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c9d:	e8 7e ff ff ff       	call   80104c20 <argfd.constprop.0>
80104ca2:	85 c0                	test   %eax,%eax
80104ca4:	78 1a                	js     80104cc0 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104ca6:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104ca8:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104cab:	e8 20 ec ff ff       	call   801038d0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104cb0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104cb4:	85 d2                	test   %edx,%edx
80104cb6:	74 18                	je     80104cd0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104cb8:	83 c3 01             	add    $0x1,%ebx
80104cbb:	83 fb 10             	cmp    $0x10,%ebx
80104cbe:	75 f0                	jne    80104cb0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104cc0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104cc3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104cc8:	89 d8                	mov    %ebx,%eax
80104cca:	5b                   	pop    %ebx
80104ccb:	5e                   	pop    %esi
80104ccc:	5d                   	pop    %ebp
80104ccd:	c3                   	ret    
80104cce:	66 90                	xchg   %ax,%ax
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104cd0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104cd4:	83 ec 0c             	sub    $0xc,%esp
80104cd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cda:	e8 f1 c0 ff ff       	call   80100dd0 <filedup>
  return fd;
80104cdf:	83 c4 10             	add    $0x10,%esp
}
80104ce2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ce5:	89 d8                	mov    %ebx,%eax
80104ce7:	5b                   	pop    %ebx
80104ce8:	5e                   	pop    %esi
80104ce9:	5d                   	pop    %ebp
80104cea:	c3                   	ret    
80104ceb:	90                   	nop
80104cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cf0 <sys_read>:

int
sys_read(void)
{
80104cf0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cf1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104cf3:	89 e5                	mov    %esp,%ebp
80104cf5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cf8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cfb:	e8 20 ff ff ff       	call   80104c20 <argfd.constprop.0>
80104d00:	85 c0                	test   %eax,%eax
80104d02:	78 4c                	js     80104d50 <sys_read+0x60>
80104d04:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d07:	83 ec 08             	sub    $0x8,%esp
80104d0a:	50                   	push   %eax
80104d0b:	6a 02                	push   $0x2
80104d0d:	e8 1e fc ff ff       	call   80104930 <argint>
80104d12:	83 c4 10             	add    $0x10,%esp
80104d15:	85 c0                	test   %eax,%eax
80104d17:	78 37                	js     80104d50 <sys_read+0x60>
80104d19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d1c:	83 ec 04             	sub    $0x4,%esp
80104d1f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d22:	50                   	push   %eax
80104d23:	6a 01                	push   $0x1
80104d25:	e8 56 fc ff ff       	call   80104980 <argptr>
80104d2a:	83 c4 10             	add    $0x10,%esp
80104d2d:	85 c0                	test   %eax,%eax
80104d2f:	78 1f                	js     80104d50 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104d31:	83 ec 04             	sub    $0x4,%esp
80104d34:	ff 75 f0             	pushl  -0x10(%ebp)
80104d37:	ff 75 f4             	pushl  -0xc(%ebp)
80104d3a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d3d:	e8 fe c1 ff ff       	call   80100f40 <fileread>
80104d42:	83 c4 10             	add    $0x10,%esp
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104d55:	c9                   	leave  
80104d56:	c3                   	ret    
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <sys_write>:

int
sys_write(void)
{
80104d60:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d61:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104d63:	89 e5                	mov    %esp,%ebp
80104d65:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d68:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d6b:	e8 b0 fe ff ff       	call   80104c20 <argfd.constprop.0>
80104d70:	85 c0                	test   %eax,%eax
80104d72:	78 4c                	js     80104dc0 <sys_write+0x60>
80104d74:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d77:	83 ec 08             	sub    $0x8,%esp
80104d7a:	50                   	push   %eax
80104d7b:	6a 02                	push   $0x2
80104d7d:	e8 ae fb ff ff       	call   80104930 <argint>
80104d82:	83 c4 10             	add    $0x10,%esp
80104d85:	85 c0                	test   %eax,%eax
80104d87:	78 37                	js     80104dc0 <sys_write+0x60>
80104d89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d8c:	83 ec 04             	sub    $0x4,%esp
80104d8f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d92:	50                   	push   %eax
80104d93:	6a 01                	push   $0x1
80104d95:	e8 e6 fb ff ff       	call   80104980 <argptr>
80104d9a:	83 c4 10             	add    $0x10,%esp
80104d9d:	85 c0                	test   %eax,%eax
80104d9f:	78 1f                	js     80104dc0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104da1:	83 ec 04             	sub    $0x4,%esp
80104da4:	ff 75 f0             	pushl  -0x10(%ebp)
80104da7:	ff 75 f4             	pushl  -0xc(%ebp)
80104daa:	ff 75 ec             	pushl  -0x14(%ebp)
80104dad:	e8 1e c2 ff ff       	call   80100fd0 <filewrite>
80104db2:	83 c4 10             	add    $0x10,%esp
}
80104db5:	c9                   	leave  
80104db6:	c3                   	ret    
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104dc5:	c9                   	leave  
80104dc6:	c3                   	ret    
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dd0 <sys_close>:

int
sys_close(void)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104dd6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104dd9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104ddc:	e8 3f fe ff ff       	call   80104c20 <argfd.constprop.0>
80104de1:	85 c0                	test   %eax,%eax
80104de3:	78 2b                	js     80104e10 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104de5:	e8 e6 ea ff ff       	call   801038d0 <myproc>
80104dea:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104ded:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104df0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104df7:	00 
  fileclose(f);
80104df8:	ff 75 f4             	pushl  -0xc(%ebp)
80104dfb:	e8 20 c0 ff ff       	call   80100e20 <fileclose>
  return 0;
80104e00:	83 c4 10             	add    $0x10,%esp
80104e03:	31 c0                	xor    %eax,%eax
}
80104e05:	c9                   	leave  
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <sys_fstat>:

int
sys_fstat(void)
{
80104e20:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e21:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104e23:	89 e5                	mov    %esp,%ebp
80104e25:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104e28:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104e2b:	e8 f0 fd ff ff       	call   80104c20 <argfd.constprop.0>
80104e30:	85 c0                	test   %eax,%eax
80104e32:	78 2c                	js     80104e60 <sys_fstat+0x40>
80104e34:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e37:	83 ec 04             	sub    $0x4,%esp
80104e3a:	6a 14                	push   $0x14
80104e3c:	50                   	push   %eax
80104e3d:	6a 01                	push   $0x1
80104e3f:	e8 3c fb ff ff       	call   80104980 <argptr>
80104e44:	83 c4 10             	add    $0x10,%esp
80104e47:	85 c0                	test   %eax,%eax
80104e49:	78 15                	js     80104e60 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104e4b:	83 ec 08             	sub    $0x8,%esp
80104e4e:	ff 75 f4             	pushl  -0xc(%ebp)
80104e51:	ff 75 f0             	pushl  -0x10(%ebp)
80104e54:	e8 97 c0 ff ff       	call   80100ef0 <filestat>
80104e59:	83 c4 10             	add    $0x10,%esp
}
80104e5c:	c9                   	leave  
80104e5d:	c3                   	ret    
80104e5e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104e65:	c9                   	leave  
80104e66:	c3                   	ret    
80104e67:	89 f6                	mov    %esi,%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	57                   	push   %edi
80104e74:	56                   	push   %esi
80104e75:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e76:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e79:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e7c:	50                   	push   %eax
80104e7d:	6a 00                	push   $0x0
80104e7f:	e8 5c fb ff ff       	call   801049e0 <argstr>
80104e84:	83 c4 10             	add    $0x10,%esp
80104e87:	85 c0                	test   %eax,%eax
80104e89:	0f 88 fb 00 00 00    	js     80104f8a <sys_link+0x11a>
80104e8f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e92:	83 ec 08             	sub    $0x8,%esp
80104e95:	50                   	push   %eax
80104e96:	6a 01                	push   $0x1
80104e98:	e8 43 fb ff ff       	call   801049e0 <argstr>
80104e9d:	83 c4 10             	add    $0x10,%esp
80104ea0:	85 c0                	test   %eax,%eax
80104ea2:	0f 88 e2 00 00 00    	js     80104f8a <sys_link+0x11a>
    return -1;

  begin_op();
80104ea8:	e8 c3 dc ff ff       	call   80102b70 <begin_op>
  if((ip = namei(old)) == 0){
80104ead:	83 ec 0c             	sub    $0xc,%esp
80104eb0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104eb3:	e8 e8 cf ff ff       	call   80101ea0 <namei>
80104eb8:	83 c4 10             	add    $0x10,%esp
80104ebb:	85 c0                	test   %eax,%eax
80104ebd:	89 c3                	mov    %eax,%ebx
80104ebf:	0f 84 f3 00 00 00    	je     80104fb8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104ec5:	83 ec 0c             	sub    $0xc,%esp
80104ec8:	50                   	push   %eax
80104ec9:	e8 a2 c7 ff ff       	call   80101670 <ilock>
  if(ip->type == T_DIR){
80104ece:	83 c4 10             	add    $0x10,%esp
80104ed1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ed6:	0f 84 c4 00 00 00    	je     80104fa0 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104edc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104ee1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104ee4:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104ee7:	53                   	push   %ebx
80104ee8:	e8 d3 c6 ff ff       	call   801015c0 <iupdate>
  iunlock(ip);
80104eed:	89 1c 24             	mov    %ebx,(%esp)
80104ef0:	e8 5b c8 ff ff       	call   80101750 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104ef5:	58                   	pop    %eax
80104ef6:	5a                   	pop    %edx
80104ef7:	57                   	push   %edi
80104ef8:	ff 75 d0             	pushl  -0x30(%ebp)
80104efb:	e8 c0 cf ff ff       	call   80101ec0 <nameiparent>
80104f00:	83 c4 10             	add    $0x10,%esp
80104f03:	85 c0                	test   %eax,%eax
80104f05:	89 c6                	mov    %eax,%esi
80104f07:	74 5b                	je     80104f64 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104f09:	83 ec 0c             	sub    $0xc,%esp
80104f0c:	50                   	push   %eax
80104f0d:	e8 5e c7 ff ff       	call   80101670 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104f12:	83 c4 10             	add    $0x10,%esp
80104f15:	8b 03                	mov    (%ebx),%eax
80104f17:	39 06                	cmp    %eax,(%esi)
80104f19:	75 3d                	jne    80104f58 <sys_link+0xe8>
80104f1b:	83 ec 04             	sub    $0x4,%esp
80104f1e:	ff 73 04             	pushl  0x4(%ebx)
80104f21:	57                   	push   %edi
80104f22:	56                   	push   %esi
80104f23:	e8 b8 ce ff ff       	call   80101de0 <dirlink>
80104f28:	83 c4 10             	add    $0x10,%esp
80104f2b:	85 c0                	test   %eax,%eax
80104f2d:	78 29                	js     80104f58 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104f2f:	83 ec 0c             	sub    $0xc,%esp
80104f32:	56                   	push   %esi
80104f33:	e8 a8 c9 ff ff       	call   801018e0 <iunlockput>
  iput(ip);
80104f38:	89 1c 24             	mov    %ebx,(%esp)
80104f3b:	e8 60 c8 ff ff       	call   801017a0 <iput>

  end_op();
80104f40:	e8 9b dc ff ff       	call   80102be0 <end_op>

  return 0;
80104f45:	83 c4 10             	add    $0x10,%esp
80104f48:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104f4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f4d:	5b                   	pop    %ebx
80104f4e:	5e                   	pop    %esi
80104f4f:	5f                   	pop    %edi
80104f50:	5d                   	pop    %ebp
80104f51:	c3                   	ret    
80104f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104f58:	83 ec 0c             	sub    $0xc,%esp
80104f5b:	56                   	push   %esi
80104f5c:	e8 7f c9 ff ff       	call   801018e0 <iunlockput>
    goto bad;
80104f61:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104f64:	83 ec 0c             	sub    $0xc,%esp
80104f67:	53                   	push   %ebx
80104f68:	e8 03 c7 ff ff       	call   80101670 <ilock>
  ip->nlink--;
80104f6d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f72:	89 1c 24             	mov    %ebx,(%esp)
80104f75:	e8 46 c6 ff ff       	call   801015c0 <iupdate>
  iunlockput(ip);
80104f7a:	89 1c 24             	mov    %ebx,(%esp)
80104f7d:	e8 5e c9 ff ff       	call   801018e0 <iunlockput>
  end_op();
80104f82:	e8 59 dc ff ff       	call   80102be0 <end_op>
  return -1;
80104f87:	83 c4 10             	add    $0x10,%esp
}
80104f8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104f8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f92:	5b                   	pop    %ebx
80104f93:	5e                   	pop    %esi
80104f94:	5f                   	pop    %edi
80104f95:	5d                   	pop    %ebp
80104f96:	c3                   	ret    
80104f97:	89 f6                	mov    %esi,%esi
80104f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104fa0:	83 ec 0c             	sub    $0xc,%esp
80104fa3:	53                   	push   %ebx
80104fa4:	e8 37 c9 ff ff       	call   801018e0 <iunlockput>
    end_op();
80104fa9:	e8 32 dc ff ff       	call   80102be0 <end_op>
    return -1;
80104fae:	83 c4 10             	add    $0x10,%esp
80104fb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fb6:	eb 92                	jmp    80104f4a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104fb8:	e8 23 dc ff ff       	call   80102be0 <end_op>
    return -1;
80104fbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fc2:	eb 86                	jmp    80104f4a <sys_link+0xda>
80104fc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104fd0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	57                   	push   %edi
80104fd4:	56                   	push   %esi
80104fd5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104fd6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104fd9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104fdc:	50                   	push   %eax
80104fdd:	6a 00                	push   $0x0
80104fdf:	e8 fc f9 ff ff       	call   801049e0 <argstr>
80104fe4:	83 c4 10             	add    $0x10,%esp
80104fe7:	85 c0                	test   %eax,%eax
80104fe9:	0f 88 82 01 00 00    	js     80105171 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104fef:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104ff2:	e8 79 db ff ff       	call   80102b70 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104ff7:	83 ec 08             	sub    $0x8,%esp
80104ffa:	53                   	push   %ebx
80104ffb:	ff 75 c0             	pushl  -0x40(%ebp)
80104ffe:	e8 bd ce ff ff       	call   80101ec0 <nameiparent>
80105003:	83 c4 10             	add    $0x10,%esp
80105006:	85 c0                	test   %eax,%eax
80105008:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010500b:	0f 84 6a 01 00 00    	je     8010517b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105011:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105014:	83 ec 0c             	sub    $0xc,%esp
80105017:	56                   	push   %esi
80105018:	e8 53 c6 ff ff       	call   80101670 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010501d:	58                   	pop    %eax
8010501e:	5a                   	pop    %edx
8010501f:	68 84 79 10 80       	push   $0x80107984
80105024:	53                   	push   %ebx
80105025:	e8 36 cb ff ff       	call   80101b60 <namecmp>
8010502a:	83 c4 10             	add    $0x10,%esp
8010502d:	85 c0                	test   %eax,%eax
8010502f:	0f 84 fc 00 00 00    	je     80105131 <sys_unlink+0x161>
80105035:	83 ec 08             	sub    $0x8,%esp
80105038:	68 83 79 10 80       	push   $0x80107983
8010503d:	53                   	push   %ebx
8010503e:	e8 1d cb ff ff       	call   80101b60 <namecmp>
80105043:	83 c4 10             	add    $0x10,%esp
80105046:	85 c0                	test   %eax,%eax
80105048:	0f 84 e3 00 00 00    	je     80105131 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010504e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105051:	83 ec 04             	sub    $0x4,%esp
80105054:	50                   	push   %eax
80105055:	53                   	push   %ebx
80105056:	56                   	push   %esi
80105057:	e8 24 cb ff ff       	call   80101b80 <dirlookup>
8010505c:	83 c4 10             	add    $0x10,%esp
8010505f:	85 c0                	test   %eax,%eax
80105061:	89 c3                	mov    %eax,%ebx
80105063:	0f 84 c8 00 00 00    	je     80105131 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105069:	83 ec 0c             	sub    $0xc,%esp
8010506c:	50                   	push   %eax
8010506d:	e8 fe c5 ff ff       	call   80101670 <ilock>

  if(ip->nlink < 1)
80105072:	83 c4 10             	add    $0x10,%esp
80105075:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010507a:	0f 8e 24 01 00 00    	jle    801051a4 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105080:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105085:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105088:	74 66                	je     801050f0 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010508a:	83 ec 04             	sub    $0x4,%esp
8010508d:	6a 10                	push   $0x10
8010508f:	6a 00                	push   $0x0
80105091:	56                   	push   %esi
80105092:	e8 a9 f5 ff ff       	call   80104640 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105097:	6a 10                	push   $0x10
80105099:	ff 75 c4             	pushl  -0x3c(%ebp)
8010509c:	56                   	push   %esi
8010509d:	ff 75 b4             	pushl  -0x4c(%ebp)
801050a0:	e8 8b c9 ff ff       	call   80101a30 <writei>
801050a5:	83 c4 20             	add    $0x20,%esp
801050a8:	83 f8 10             	cmp    $0x10,%eax
801050ab:	0f 85 e6 00 00 00    	jne    80105197 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801050b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801050b6:	0f 84 9c 00 00 00    	je     80105158 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801050bc:	83 ec 0c             	sub    $0xc,%esp
801050bf:	ff 75 b4             	pushl  -0x4c(%ebp)
801050c2:	e8 19 c8 ff ff       	call   801018e0 <iunlockput>

  ip->nlink--;
801050c7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050cc:	89 1c 24             	mov    %ebx,(%esp)
801050cf:	e8 ec c4 ff ff       	call   801015c0 <iupdate>
  iunlockput(ip);
801050d4:	89 1c 24             	mov    %ebx,(%esp)
801050d7:	e8 04 c8 ff ff       	call   801018e0 <iunlockput>

  end_op();
801050dc:	e8 ff da ff ff       	call   80102be0 <end_op>

  return 0;
801050e1:	83 c4 10             	add    $0x10,%esp
801050e4:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801050e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050e9:	5b                   	pop    %ebx
801050ea:	5e                   	pop    %esi
801050eb:	5f                   	pop    %edi
801050ec:	5d                   	pop    %ebp
801050ed:	c3                   	ret    
801050ee:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801050f0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801050f4:	76 94                	jbe    8010508a <sys_unlink+0xba>
801050f6:	bf 20 00 00 00       	mov    $0x20,%edi
801050fb:	eb 0f                	jmp    8010510c <sys_unlink+0x13c>
801050fd:	8d 76 00             	lea    0x0(%esi),%esi
80105100:	83 c7 10             	add    $0x10,%edi
80105103:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105106:	0f 83 7e ff ff ff    	jae    8010508a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010510c:	6a 10                	push   $0x10
8010510e:	57                   	push   %edi
8010510f:	56                   	push   %esi
80105110:	53                   	push   %ebx
80105111:	e8 1a c8 ff ff       	call   80101930 <readi>
80105116:	83 c4 10             	add    $0x10,%esp
80105119:	83 f8 10             	cmp    $0x10,%eax
8010511c:	75 6c                	jne    8010518a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010511e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105123:	74 db                	je     80105100 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105125:	83 ec 0c             	sub    $0xc,%esp
80105128:	53                   	push   %ebx
80105129:	e8 b2 c7 ff ff       	call   801018e0 <iunlockput>
    goto bad;
8010512e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105131:	83 ec 0c             	sub    $0xc,%esp
80105134:	ff 75 b4             	pushl  -0x4c(%ebp)
80105137:	e8 a4 c7 ff ff       	call   801018e0 <iunlockput>
  end_op();
8010513c:	e8 9f da ff ff       	call   80102be0 <end_op>
  return -1;
80105141:	83 c4 10             	add    $0x10,%esp
}
80105144:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105147:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010514c:	5b                   	pop    %ebx
8010514d:	5e                   	pop    %esi
8010514e:	5f                   	pop    %edi
8010514f:	5d                   	pop    %ebp
80105150:	c3                   	ret    
80105151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105158:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010515b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010515e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105163:	50                   	push   %eax
80105164:	e8 57 c4 ff ff       	call   801015c0 <iupdate>
80105169:	83 c4 10             	add    $0x10,%esp
8010516c:	e9 4b ff ff ff       	jmp    801050bc <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105171:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105176:	e9 6b ff ff ff       	jmp    801050e6 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010517b:	e8 60 da ff ff       	call   80102be0 <end_op>
    return -1;
80105180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105185:	e9 5c ff ff ff       	jmp    801050e6 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010518a:	83 ec 0c             	sub    $0xc,%esp
8010518d:	68 a8 79 10 80       	push   $0x801079a8
80105192:	e8 d9 b1 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105197:	83 ec 0c             	sub    $0xc,%esp
8010519a:	68 ba 79 10 80       	push   $0x801079ba
8010519f:	e8 cc b1 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801051a4:	83 ec 0c             	sub    $0xc,%esp
801051a7:	68 96 79 10 80       	push   $0x80107996
801051ac:	e8 bf b1 ff ff       	call   80100370 <panic>
801051b1:	eb 0d                	jmp    801051c0 <sys_open>
801051b3:	90                   	nop
801051b4:	90                   	nop
801051b5:	90                   	nop
801051b6:	90                   	nop
801051b7:	90                   	nop
801051b8:	90                   	nop
801051b9:	90                   	nop
801051ba:	90                   	nop
801051bb:	90                   	nop
801051bc:	90                   	nop
801051bd:	90                   	nop
801051be:	90                   	nop
801051bf:	90                   	nop

801051c0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	57                   	push   %edi
801051c4:	56                   	push   %esi
801051c5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051c6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
801051c9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801051cc:	50                   	push   %eax
801051cd:	6a 00                	push   $0x0
801051cf:	e8 0c f8 ff ff       	call   801049e0 <argstr>
801051d4:	83 c4 10             	add    $0x10,%esp
801051d7:	85 c0                	test   %eax,%eax
801051d9:	0f 88 9e 00 00 00    	js     8010527d <sys_open+0xbd>
801051df:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801051e2:	83 ec 08             	sub    $0x8,%esp
801051e5:	50                   	push   %eax
801051e6:	6a 01                	push   $0x1
801051e8:	e8 43 f7 ff ff       	call   80104930 <argint>
801051ed:	83 c4 10             	add    $0x10,%esp
801051f0:	85 c0                	test   %eax,%eax
801051f2:	0f 88 85 00 00 00    	js     8010527d <sys_open+0xbd>
    return -1;

  begin_op();
801051f8:	e8 73 d9 ff ff       	call   80102b70 <begin_op>

  if(omode & O_CREATE){
801051fd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105201:	0f 85 89 00 00 00    	jne    80105290 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105207:	83 ec 0c             	sub    $0xc,%esp
8010520a:	ff 75 e0             	pushl  -0x20(%ebp)
8010520d:	e8 8e cc ff ff       	call   80101ea0 <namei>
80105212:	83 c4 10             	add    $0x10,%esp
80105215:	85 c0                	test   %eax,%eax
80105217:	89 c6                	mov    %eax,%esi
80105219:	0f 84 8e 00 00 00    	je     801052ad <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010521f:	83 ec 0c             	sub    $0xc,%esp
80105222:	50                   	push   %eax
80105223:	e8 48 c4 ff ff       	call   80101670 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105228:	83 c4 10             	add    $0x10,%esp
8010522b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105230:	0f 84 d2 00 00 00    	je     80105308 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105236:	e8 25 bb ff ff       	call   80100d60 <filealloc>
8010523b:	85 c0                	test   %eax,%eax
8010523d:	89 c7                	mov    %eax,%edi
8010523f:	74 2b                	je     8010526c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105241:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105243:	e8 88 e6 ff ff       	call   801038d0 <myproc>
80105248:	90                   	nop
80105249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105250:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105254:	85 d2                	test   %edx,%edx
80105256:	74 68                	je     801052c0 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105258:	83 c3 01             	add    $0x1,%ebx
8010525b:	83 fb 10             	cmp    $0x10,%ebx
8010525e:	75 f0                	jne    80105250 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105260:	83 ec 0c             	sub    $0xc,%esp
80105263:	57                   	push   %edi
80105264:	e8 b7 bb ff ff       	call   80100e20 <fileclose>
80105269:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010526c:	83 ec 0c             	sub    $0xc,%esp
8010526f:	56                   	push   %esi
80105270:	e8 6b c6 ff ff       	call   801018e0 <iunlockput>
    end_op();
80105275:	e8 66 d9 ff ff       	call   80102be0 <end_op>
    return -1;
8010527a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010527d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105280:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105285:	89 d8                	mov    %ebx,%eax
80105287:	5b                   	pop    %ebx
80105288:	5e                   	pop    %esi
80105289:	5f                   	pop    %edi
8010528a:	5d                   	pop    %ebp
8010528b:	c3                   	ret    
8010528c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105290:	83 ec 0c             	sub    $0xc,%esp
80105293:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105296:	31 c9                	xor    %ecx,%ecx
80105298:	6a 00                	push   $0x0
8010529a:	ba 02 00 00 00       	mov    $0x2,%edx
8010529f:	e8 dc f7 ff ff       	call   80104a80 <create>
    if(ip == 0){
801052a4:	83 c4 10             	add    $0x10,%esp
801052a7:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801052a9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801052ab:	75 89                	jne    80105236 <sys_open+0x76>
      end_op();
801052ad:	e8 2e d9 ff ff       	call   80102be0 <end_op>
      return -1;
801052b2:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052b7:	eb 40                	jmp    801052f9 <sys_open+0x139>
801052b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052c0:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801052c3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052c7:	56                   	push   %esi
801052c8:	e8 83 c4 ff ff       	call   80101750 <iunlock>
  end_op();
801052cd:	e8 0e d9 ff ff       	call   80102be0 <end_op>

  f->type = FD_INODE;
801052d2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052db:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801052de:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801052e1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801052e8:	89 c2                	mov    %eax,%edx
801052ea:	f7 d2                	not    %edx
801052ec:	88 57 08             	mov    %dl,0x8(%edi)
801052ef:	80 67 08 01          	andb   $0x1,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052f3:	a8 03                	test   $0x3,%al
801052f5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801052f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052fc:	89 d8                	mov    %ebx,%eax
801052fe:	5b                   	pop    %ebx
801052ff:	5e                   	pop    %esi
80105300:	5f                   	pop    %edi
80105301:	5d                   	pop    %ebp
80105302:	c3                   	ret    
80105303:	90                   	nop
80105304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105308:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010530b:	85 c9                	test   %ecx,%ecx
8010530d:	0f 84 23 ff ff ff    	je     80105236 <sys_open+0x76>
80105313:	e9 54 ff ff ff       	jmp    8010526c <sys_open+0xac>
80105318:	90                   	nop
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105320 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105326:	e8 45 d8 ff ff       	call   80102b70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010532b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010532e:	83 ec 08             	sub    $0x8,%esp
80105331:	50                   	push   %eax
80105332:	6a 00                	push   $0x0
80105334:	e8 a7 f6 ff ff       	call   801049e0 <argstr>
80105339:	83 c4 10             	add    $0x10,%esp
8010533c:	85 c0                	test   %eax,%eax
8010533e:	78 30                	js     80105370 <sys_mkdir+0x50>
80105340:	83 ec 0c             	sub    $0xc,%esp
80105343:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105346:	31 c9                	xor    %ecx,%ecx
80105348:	6a 00                	push   $0x0
8010534a:	ba 01 00 00 00       	mov    $0x1,%edx
8010534f:	e8 2c f7 ff ff       	call   80104a80 <create>
80105354:	83 c4 10             	add    $0x10,%esp
80105357:	85 c0                	test   %eax,%eax
80105359:	74 15                	je     80105370 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010535b:	83 ec 0c             	sub    $0xc,%esp
8010535e:	50                   	push   %eax
8010535f:	e8 7c c5 ff ff       	call   801018e0 <iunlockput>
  end_op();
80105364:	e8 77 d8 ff ff       	call   80102be0 <end_op>
  return 0;
80105369:	83 c4 10             	add    $0x10,%esp
8010536c:	31 c0                	xor    %eax,%eax
}
8010536e:	c9                   	leave  
8010536f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105370:	e8 6b d8 ff ff       	call   80102be0 <end_op>
    return -1;
80105375:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010537a:	c9                   	leave  
8010537b:	c3                   	ret    
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105380 <sys_mknod>:

int
sys_mknod(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105386:	e8 e5 d7 ff ff       	call   80102b70 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010538b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010538e:	83 ec 08             	sub    $0x8,%esp
80105391:	50                   	push   %eax
80105392:	6a 00                	push   $0x0
80105394:	e8 47 f6 ff ff       	call   801049e0 <argstr>
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	85 c0                	test   %eax,%eax
8010539e:	78 60                	js     80105400 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801053a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053a3:	83 ec 08             	sub    $0x8,%esp
801053a6:	50                   	push   %eax
801053a7:	6a 01                	push   $0x1
801053a9:	e8 82 f5 ff ff       	call   80104930 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801053ae:	83 c4 10             	add    $0x10,%esp
801053b1:	85 c0                	test   %eax,%eax
801053b3:	78 4b                	js     80105400 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801053b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053b8:	83 ec 08             	sub    $0x8,%esp
801053bb:	50                   	push   %eax
801053bc:	6a 02                	push   $0x2
801053be:	e8 6d f5 ff ff       	call   80104930 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801053c3:	83 c4 10             	add    $0x10,%esp
801053c6:	85 c0                	test   %eax,%eax
801053c8:	78 36                	js     80105400 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
801053ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801053ce:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
801053d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801053d5:	ba 03 00 00 00       	mov    $0x3,%edx
801053da:	50                   	push   %eax
801053db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801053de:	e8 9d f6 ff ff       	call   80104a80 <create>
801053e3:	83 c4 10             	add    $0x10,%esp
801053e6:	85 c0                	test   %eax,%eax
801053e8:	74 16                	je     80105400 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801053ea:	83 ec 0c             	sub    $0xc,%esp
801053ed:	50                   	push   %eax
801053ee:	e8 ed c4 ff ff       	call   801018e0 <iunlockput>
  end_op();
801053f3:	e8 e8 d7 ff ff       	call   80102be0 <end_op>
  return 0;
801053f8:	83 c4 10             	add    $0x10,%esp
801053fb:	31 c0                	xor    %eax,%eax
}
801053fd:	c9                   	leave  
801053fe:	c3                   	ret    
801053ff:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105400:	e8 db d7 ff ff       	call   80102be0 <end_op>
    return -1;
80105405:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010540a:	c9                   	leave  
8010540b:	c3                   	ret    
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105410 <sys_chdir>:

int
sys_chdir(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	56                   	push   %esi
80105414:	53                   	push   %ebx
80105415:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105418:	e8 b3 e4 ff ff       	call   801038d0 <myproc>
8010541d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010541f:	e8 4c d7 ff ff       	call   80102b70 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105424:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105427:	83 ec 08             	sub    $0x8,%esp
8010542a:	50                   	push   %eax
8010542b:	6a 00                	push   $0x0
8010542d:	e8 ae f5 ff ff       	call   801049e0 <argstr>
80105432:	83 c4 10             	add    $0x10,%esp
80105435:	85 c0                	test   %eax,%eax
80105437:	78 77                	js     801054b0 <sys_chdir+0xa0>
80105439:	83 ec 0c             	sub    $0xc,%esp
8010543c:	ff 75 f4             	pushl  -0xc(%ebp)
8010543f:	e8 5c ca ff ff       	call   80101ea0 <namei>
80105444:	83 c4 10             	add    $0x10,%esp
80105447:	85 c0                	test   %eax,%eax
80105449:	89 c3                	mov    %eax,%ebx
8010544b:	74 63                	je     801054b0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010544d:	83 ec 0c             	sub    $0xc,%esp
80105450:	50                   	push   %eax
80105451:	e8 1a c2 ff ff       	call   80101670 <ilock>
  if(ip->type != T_DIR){
80105456:	83 c4 10             	add    $0x10,%esp
80105459:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010545e:	75 30                	jne    80105490 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105460:	83 ec 0c             	sub    $0xc,%esp
80105463:	53                   	push   %ebx
80105464:	e8 e7 c2 ff ff       	call   80101750 <iunlock>
  iput(curproc->cwd);
80105469:	58                   	pop    %eax
8010546a:	ff 76 68             	pushl  0x68(%esi)
8010546d:	e8 2e c3 ff ff       	call   801017a0 <iput>
  end_op();
80105472:	e8 69 d7 ff ff       	call   80102be0 <end_op>
  curproc->cwd = ip;
80105477:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010547a:	83 c4 10             	add    $0x10,%esp
8010547d:	31 c0                	xor    %eax,%eax
}
8010547f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105482:	5b                   	pop    %ebx
80105483:	5e                   	pop    %esi
80105484:	5d                   	pop    %ebp
80105485:	c3                   	ret    
80105486:	8d 76 00             	lea    0x0(%esi),%esi
80105489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105490:	83 ec 0c             	sub    $0xc,%esp
80105493:	53                   	push   %ebx
80105494:	e8 47 c4 ff ff       	call   801018e0 <iunlockput>
    end_op();
80105499:	e8 42 d7 ff ff       	call   80102be0 <end_op>
    return -1;
8010549e:	83 c4 10             	add    $0x10,%esp
801054a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a6:	eb d7                	jmp    8010547f <sys_chdir+0x6f>
801054a8:	90                   	nop
801054a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801054b0:	e8 2b d7 ff ff       	call   80102be0 <end_op>
    return -1;
801054b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ba:	eb c3                	jmp    8010547f <sys_chdir+0x6f>
801054bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	57                   	push   %edi
801054c4:	56                   	push   %esi
801054c5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054c6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
801054cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054d2:	50                   	push   %eax
801054d3:	6a 00                	push   $0x0
801054d5:	e8 06 f5 ff ff       	call   801049e0 <argstr>
801054da:	83 c4 10             	add    $0x10,%esp
801054dd:	85 c0                	test   %eax,%eax
801054df:	78 7f                	js     80105560 <sys_exec+0xa0>
801054e1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801054e7:	83 ec 08             	sub    $0x8,%esp
801054ea:	50                   	push   %eax
801054eb:	6a 01                	push   $0x1
801054ed:	e8 3e f4 ff ff       	call   80104930 <argint>
801054f2:	83 c4 10             	add    $0x10,%esp
801054f5:	85 c0                	test   %eax,%eax
801054f7:	78 67                	js     80105560 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801054f9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801054ff:	83 ec 04             	sub    $0x4,%esp
80105502:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105508:	68 80 00 00 00       	push   $0x80
8010550d:	6a 00                	push   $0x0
8010550f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105515:	50                   	push   %eax
80105516:	31 db                	xor    %ebx,%ebx
80105518:	e8 23 f1 ff ff       	call   80104640 <memset>
8010551d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105520:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105526:	83 ec 08             	sub    $0x8,%esp
80105529:	57                   	push   %edi
8010552a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010552d:	50                   	push   %eax
8010552e:	e8 5d f3 ff ff       	call   80104890 <fetchint>
80105533:	83 c4 10             	add    $0x10,%esp
80105536:	85 c0                	test   %eax,%eax
80105538:	78 26                	js     80105560 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010553a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105540:	85 c0                	test   %eax,%eax
80105542:	74 2c                	je     80105570 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105544:	83 ec 08             	sub    $0x8,%esp
80105547:	56                   	push   %esi
80105548:	50                   	push   %eax
80105549:	e8 82 f3 ff ff       	call   801048d0 <fetchstr>
8010554e:	83 c4 10             	add    $0x10,%esp
80105551:	85 c0                	test   %eax,%eax
80105553:	78 0b                	js     80105560 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105555:	83 c3 01             	add    $0x1,%ebx
80105558:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010555b:	83 fb 20             	cmp    $0x20,%ebx
8010555e:	75 c0                	jne    80105520 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105560:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105563:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105568:	5b                   	pop    %ebx
80105569:	5e                   	pop    %esi
8010556a:	5f                   	pop    %edi
8010556b:	5d                   	pop    %ebp
8010556c:	c3                   	ret    
8010556d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105570:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105576:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105579:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105580:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105584:	50                   	push   %eax
80105585:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010558b:	e8 50 b4 ff ff       	call   801009e0 <exec>
80105590:	83 c4 10             	add    $0x10,%esp
}
80105593:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105596:	5b                   	pop    %ebx
80105597:	5e                   	pop    %esi
80105598:	5f                   	pop    %edi
80105599:	5d                   	pop    %ebp
8010559a:	c3                   	ret    
8010559b:	90                   	nop
8010559c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055a0 <sys_pipe>:

int
sys_pipe(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	57                   	push   %edi
801055a4:	56                   	push   %esi
801055a5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055a6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
801055a9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055ac:	6a 08                	push   $0x8
801055ae:	50                   	push   %eax
801055af:	6a 00                	push   $0x0
801055b1:	e8 ca f3 ff ff       	call   80104980 <argptr>
801055b6:	83 c4 10             	add    $0x10,%esp
801055b9:	85 c0                	test   %eax,%eax
801055bb:	78 4a                	js     80105607 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801055bd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055c0:	83 ec 08             	sub    $0x8,%esp
801055c3:	50                   	push   %eax
801055c4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801055c7:	50                   	push   %eax
801055c8:	e8 13 dd ff ff       	call   801032e0 <pipealloc>
801055cd:	83 c4 10             	add    $0x10,%esp
801055d0:	85 c0                	test   %eax,%eax
801055d2:	78 33                	js     80105607 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801055d4:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801055d6:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801055d9:	e8 f2 e2 ff ff       	call   801038d0 <myproc>
801055de:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801055e0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801055e4:	85 f6                	test   %esi,%esi
801055e6:	74 30                	je     80105618 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801055e8:	83 c3 01             	add    $0x1,%ebx
801055eb:	83 fb 10             	cmp    $0x10,%ebx
801055ee:	75 f0                	jne    801055e0 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801055f0:	83 ec 0c             	sub    $0xc,%esp
801055f3:	ff 75 e0             	pushl  -0x20(%ebp)
801055f6:	e8 25 b8 ff ff       	call   80100e20 <fileclose>
    fileclose(wf);
801055fb:	58                   	pop    %eax
801055fc:	ff 75 e4             	pushl  -0x1c(%ebp)
801055ff:	e8 1c b8 ff ff       	call   80100e20 <fileclose>
    return -1;
80105604:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105607:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010560a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010560f:	5b                   	pop    %ebx
80105610:	5e                   	pop    %esi
80105611:	5f                   	pop    %edi
80105612:	5d                   	pop    %ebp
80105613:	c3                   	ret    
80105614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105618:	8d 73 08             	lea    0x8(%ebx),%esi
8010561b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010561f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105622:	e8 a9 e2 ff ff       	call   801038d0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105627:	31 d2                	xor    %edx,%edx
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105630:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105634:	85 c9                	test   %ecx,%ecx
80105636:	74 18                	je     80105650 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105638:	83 c2 01             	add    $0x1,%edx
8010563b:	83 fa 10             	cmp    $0x10,%edx
8010563e:	75 f0                	jne    80105630 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105640:	e8 8b e2 ff ff       	call   801038d0 <myproc>
80105645:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010564c:	00 
8010564d:	eb a1                	jmp    801055f0 <sys_pipe+0x50>
8010564f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105650:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105654:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105657:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105659:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010565c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010565f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105662:	31 c0                	xor    %eax,%eax
}
80105664:	5b                   	pop    %ebx
80105665:	5e                   	pop    %esi
80105666:	5f                   	pop    %edi
80105667:	5d                   	pop    %ebp
80105668:	c3                   	ret    
80105669:	66 90                	xchg   %ax,%ax
8010566b:	66 90                	xchg   %ax,%ax
8010566d:	66 90                	xchg   %ax,%ax
8010566f:	90                   	nop

80105670 <sys_fork>:
#include "proc.h"
#include "pstat.h"

int
sys_fork(void)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105673:	5d                   	pop    %ebp
#include "pstat.h"

int
sys_fork(void)
{
  return fork();
80105674:	e9 f7 e3 ff ff       	jmp    80103a70 <fork>
80105679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105680 <sys_exit>:
}

int
sys_exit(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	83 ec 08             	sub    $0x8,%esp
  exit();
80105686:	e8 75 e6 ff ff       	call   80103d00 <exit>
  return 0;  // not reached
}
8010568b:	31 c0                	xor    %eax,%eax
8010568d:	c9                   	leave  
8010568e:	c3                   	ret    
8010568f:	90                   	nop

80105690 <sys_wait>:

int
sys_wait(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105693:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105694:	e9 a7 e8 ff ff       	jmp    80103f40 <wait>
80105699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801056a0 <sys_kill>:
}

int
sys_kill(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801056a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056a9:	50                   	push   %eax
801056aa:	6a 00                	push   $0x0
801056ac:	e8 7f f2 ff ff       	call   80104930 <argint>
801056b1:	83 c4 10             	add    $0x10,%esp
801056b4:	85 c0                	test   %eax,%eax
801056b6:	78 18                	js     801056d0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801056b8:	83 ec 0c             	sub    $0xc,%esp
801056bb:	ff 75 f4             	pushl  -0xc(%ebp)
801056be:	e8 dd e9 ff ff       	call   801040a0 <kill>
801056c3:	83 c4 10             	add    $0x10,%esp
}
801056c6:	c9                   	leave  
801056c7:	c3                   	ret    
801056c8:	90                   	nop
801056c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801056d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801056d5:	c9                   	leave  
801056d6:	c3                   	ret    
801056d7:	89 f6                	mov    %esi,%esi
801056d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056e0 <sys_shutdown>:

int 
sys_shutdown(void)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	83 ec 14             	sub    $0x14,%esp
cprintf("Shutdown signal sent\n");
801056e6:	68 c9 79 10 80       	push   $0x801079c9
801056eb:	e8 70 af ff ff       	call   80100660 <cprintf>
}

static inline void
outw(ushort port, ushort data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801056f0:	ba 04 b0 ff ff       	mov    $0xffffb004,%edx
801056f5:	b8 00 20 00 00       	mov    $0x2000,%eax
801056fa:	66 ef                	out    %ax,(%dx)
outw(0xB004,0x0 | 0x2000);
return 0;
}
801056fc:	31 c0                	xor    %eax,%eax
801056fe:	c9                   	leave  
801056ff:	c3                   	ret    

80105700 <sys_getpid>:

int
sys_getpid(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105706:	e8 c5 e1 ff ff       	call   801038d0 <myproc>
8010570b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010570e:	c9                   	leave  
8010570f:	c3                   	ret    

80105710 <sys_getppid>:

int
sys_getppid(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	83 ec 08             	sub    $0x8,%esp
return myproc()-> parent -> pid;
80105716:	e8 b5 e1 ff ff       	call   801038d0 <myproc>
8010571b:	8b 40 14             	mov    0x14(%eax),%eax
8010571e:	8b 40 10             	mov    0x10(%eax),%eax
}
80105721:	c9                   	leave  
80105722:	c3                   	ret    
80105723:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105730 <sys_getAllPids>:

struct pstat pstat;
int
sys_getAllPids(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	57                   	push   %edi
80105734:	56                   	push   %esi
80105735:	53                   	push   %ebx

struct pstat *st;
if(argptr(0, (void*)&st , sizeof(*st)) < 0)
80105736:	8d 45 e4             	lea    -0x1c(%ebp),%eax
}

struct pstat pstat;
int
sys_getAllPids(void)
{
80105739:	83 ec 20             	sub    $0x20,%esp

struct pstat *st;
if(argptr(0, (void*)&st , sizeof(*st)) < 0)
8010573c:	68 00 08 00 00       	push   $0x800
80105741:	50                   	push   %eax
80105742:	6a 00                	push   $0x0
80105744:	e8 37 f2 ff ff       	call   80104980 <argptr>
80105749:	83 c4 10             	add    $0x10,%esp
8010574c:	85 c0                	test   %eax,%eax
8010574e:	0f 88 88 00 00 00    	js     801057dc <sys_getAllPids+0xac>
80105754:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105757:	31 c0                	xor    %eax,%eax
80105759:	31 d2                	xor    %edx,%edx
8010575b:	90                   	nop
8010575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
int i;
for(i=0;i< NPROC; i++){
 st -> inuse[i] = pstat.inuse[i];
80105760:	8b 98 20 2d 11 80    	mov    -0x7feed2e0(%eax),%ebx
80105766:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
 st -> pid[i] = pstat.pid[i];
80105769:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010576c:	8b b0 20 2e 11 80    	mov    -0x7feed1e0(%eax),%esi
80105772:	8d 3c 91             	lea    (%ecx,%edx,4),%edi
80105775:	89 b7 00 01 00 00    	mov    %esi,0x100(%edi)
 st -> name[i][0] = pstat.name[i][0];
8010577b:	0f b6 1c 85 20 2f 11 	movzbl -0x7feed0e0(,%eax,4),%ebx
80105782:	80 
80105783:	8d 72 20             	lea    0x20(%edx),%esi
80105786:	c1 e6 04             	shl    $0x4,%esi
80105789:	88 1c 31             	mov    %bl,(%ecx,%esi,1)
    st -> name[i][1] = pstat.name[i][1];
8010578c:	0f b6 1c 85 21 2f 11 	movzbl -0x7feed0df(,%eax,4),%ebx
80105793:	80 
80105794:	89 d6                	mov    %edx,%esi
80105796:	c1 e6 04             	shl    $0x4,%esi

struct pstat *st;
if(argptr(0, (void*)&st , sizeof(*st)) < 0)
    return -1;
int i;
for(i=0;i< NPROC; i++){
80105799:	83 c2 01             	add    $0x1,%edx
 st -> inuse[i] = pstat.inuse[i];
 st -> pid[i] = pstat.pid[i];
 st -> name[i][0] = pstat.name[i][0];
    st -> name[i][1] = pstat.name[i][1];
8010579c:	01 ce                	add    %ecx,%esi
8010579e:	88 9e 01 02 00 00    	mov    %bl,0x201(%esi)
        st -> name[i][2] = pstat.name[i][2];
801057a4:	0f b6 1c 85 22 2f 11 	movzbl -0x7feed0de(,%eax,4),%ebx
801057ab:	80 
801057ac:	83 c0 04             	add    $0x4,%eax
801057af:	88 9e 02 02 00 00    	mov    %bl,0x202(%esi)
 st -> hticks[i]= pstat.hticks[i];
801057b5:	8b b0 1c 33 11 80    	mov    -0x7feecce4(%eax),%esi
801057bb:	89 b7 00 06 00 00    	mov    %esi,0x600(%edi)
 st -> lticks[i]= pstat.lticks[i];
801057c1:	8b b0 1c 34 11 80    	mov    -0x7feecbe4(%eax),%esi

struct pstat *st;
if(argptr(0, (void*)&st , sizeof(*st)) < 0)
    return -1;
int i;
for(i=0;i< NPROC; i++){
801057c7:	83 fa 40             	cmp    $0x40,%edx
 st -> pid[i] = pstat.pid[i];
 st -> name[i][0] = pstat.name[i][0];
    st -> name[i][1] = pstat.name[i][1];
        st -> name[i][2] = pstat.name[i][2];
 st -> hticks[i]= pstat.hticks[i];
 st -> lticks[i]= pstat.lticks[i];
801057ca:	89 b7 00 07 00 00    	mov    %esi,0x700(%edi)

struct pstat *st;
if(argptr(0, (void*)&st , sizeof(*st)) < 0)
    return -1;
int i;
for(i=0;i< NPROC; i++){
801057d0:	75 8e                	jne    80105760 <sys_getAllPids+0x30>
    st -> name[i][1] = pstat.name[i][1];
        st -> name[i][2] = pstat.name[i][2];
 st -> hticks[i]= pstat.hticks[i];
 st -> lticks[i]= pstat.lticks[i];
}
return 0;
801057d2:	31 c0                	xor    %eax,%eax

}
801057d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057d7:	5b                   	pop    %ebx
801057d8:	5e                   	pop    %esi
801057d9:	5f                   	pop    %edi
801057da:	5d                   	pop    %ebp
801057db:	c3                   	ret    
sys_getAllPids(void)
{

struct pstat *st;
if(argptr(0, (void*)&st , sizeof(*st)) < 0)
    return -1;
801057dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057e1:	eb f1                	jmp    801057d4 <sys_getAllPids+0xa4>
801057e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057f0 <sys_sbrk>:
}


int
sys_sbrk(void)
{
801057f0:	55                   	push   %ebp
801057f1:	89 e5                	mov    %esp,%ebp
801057f3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
}


int
sys_sbrk(void)
{
801057f7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057fa:	50                   	push   %eax
801057fb:	6a 00                	push   $0x0
801057fd:	e8 2e f1 ff ff       	call   80104930 <argint>
80105802:	83 c4 10             	add    $0x10,%esp
80105805:	85 c0                	test   %eax,%eax
80105807:	78 27                	js     80105830 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105809:	e8 c2 e0 ff ff       	call   801038d0 <myproc>
  if(growproc(n) < 0)
8010580e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105811:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105813:	ff 75 f4             	pushl  -0xc(%ebp)
80105816:	e8 d5 e1 ff ff       	call   801039f0 <growproc>
8010581b:	83 c4 10             	add    $0x10,%esp
8010581e:	85 c0                	test   %eax,%eax
80105820:	78 0e                	js     80105830 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105822:	89 d8                	mov    %ebx,%eax
80105824:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105827:	c9                   	leave  
80105828:	c3                   	ret    
80105829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105830:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105835:	eb eb                	jmp    80105822 <sys_sbrk+0x32>
80105837:	89 f6                	mov    %esi,%esi
80105839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105840 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105844:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105847:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010584a:	50                   	push   %eax
8010584b:	6a 00                	push   $0x0
8010584d:	e8 de f0 ff ff       	call   80104930 <argint>
80105852:	83 c4 10             	add    $0x10,%esp
80105855:	85 c0                	test   %eax,%eax
80105857:	0f 88 8a 00 00 00    	js     801058e7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010585d:	83 ec 0c             	sub    $0xc,%esp
80105860:	68 60 54 11 80       	push   $0x80115460
80105865:	e8 66 ec ff ff       	call   801044d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010586a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010586d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105870:	8b 1d a0 5c 11 80    	mov    0x80115ca0,%ebx
  while(ticks - ticks0 < n){
80105876:	85 d2                	test   %edx,%edx
80105878:	75 27                	jne    801058a1 <sys_sleep+0x61>
8010587a:	eb 54                	jmp    801058d0 <sys_sleep+0x90>
8010587c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105880:	83 ec 08             	sub    $0x8,%esp
80105883:	68 60 54 11 80       	push   $0x80115460
80105888:	68 a0 5c 11 80       	push   $0x80115ca0
8010588d:	e8 ee e5 ff ff       	call   80103e80 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105892:	a1 a0 5c 11 80       	mov    0x80115ca0,%eax
80105897:	83 c4 10             	add    $0x10,%esp
8010589a:	29 d8                	sub    %ebx,%eax
8010589c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010589f:	73 2f                	jae    801058d0 <sys_sleep+0x90>
    if(myproc()->killed){
801058a1:	e8 2a e0 ff ff       	call   801038d0 <myproc>
801058a6:	8b 40 24             	mov    0x24(%eax),%eax
801058a9:	85 c0                	test   %eax,%eax
801058ab:	74 d3                	je     80105880 <sys_sleep+0x40>
      release(&tickslock);
801058ad:	83 ec 0c             	sub    $0xc,%esp
801058b0:	68 60 54 11 80       	push   $0x80115460
801058b5:	e8 36 ed ff ff       	call   801045f0 <release>
      return -1;
801058ba:	83 c4 10             	add    $0x10,%esp
801058bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801058c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058c5:	c9                   	leave  
801058c6:	c3                   	ret    
801058c7:	89 f6                	mov    %esi,%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801058d0:	83 ec 0c             	sub    $0xc,%esp
801058d3:	68 60 54 11 80       	push   $0x80115460
801058d8:	e8 13 ed ff ff       	call   801045f0 <release>
  return 0;
801058dd:	83 c4 10             	add    $0x10,%esp
801058e0:	31 c0                	xor    %eax,%eax
}
801058e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058e5:	c9                   	leave  
801058e6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801058e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ec:	eb d4                	jmp    801058c2 <sys_sleep+0x82>
801058ee:	66 90                	xchg   %ax,%ax

801058f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	53                   	push   %ebx
801058f4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801058f7:	68 60 54 11 80       	push   $0x80115460
801058fc:	e8 cf eb ff ff       	call   801044d0 <acquire>
  xticks = ticks;
80105901:	8b 1d a0 5c 11 80    	mov    0x80115ca0,%ebx
  release(&tickslock);
80105907:	c7 04 24 60 54 11 80 	movl   $0x80115460,(%esp)
8010590e:	e8 dd ec ff ff       	call   801045f0 <release>
  return xticks;
}
80105913:	89 d8                	mov    %ebx,%eax
80105915:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105918:	c9                   	leave  
80105919:	c3                   	ret    
8010591a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105920 <sys_cps>:

int
sys_cps(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
  return cps ();
}
80105923:	5d                   	pop    %ebp
}

int
sys_cps(void)
{
  return cps ();
80105924:	e9 c7 e8 ff ff       	jmp    801041f0 <cps>
80105929:	66 90                	xchg   %ax,%ax
8010592b:	66 90                	xchg   %ax,%ax
8010592d:	66 90                	xchg   %ax,%ax
8010592f:	90                   	nop

80105930 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105930:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105931:	ba 43 00 00 00       	mov    $0x43,%edx
80105936:	b8 34 00 00 00       	mov    $0x34,%eax
8010593b:	89 e5                	mov    %esp,%ebp
8010593d:	83 ec 14             	sub    $0x14,%esp
80105940:	ee                   	out    %al,(%dx)
80105941:	ba 40 00 00 00       	mov    $0x40,%edx
80105946:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
8010594b:	ee                   	out    %al,(%dx)
8010594c:	b8 2e 00 00 00       	mov    $0x2e,%eax
80105951:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
80105952:	6a 00                	push   $0x0
80105954:	e8 b7 d8 ff ff       	call   80103210 <picenable>
}
80105959:	83 c4 10             	add    $0x10,%esp
8010595c:	c9                   	leave  
8010595d:	c3                   	ret    

8010595e <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010595e:	1e                   	push   %ds
  pushl %es
8010595f:	06                   	push   %es
  pushl %fs
80105960:	0f a0                	push   %fs
  pushl %gs
80105962:	0f a8                	push   %gs
  pushal
80105964:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105965:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105969:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010596b:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010596d:	54                   	push   %esp
  call trap
8010596e:	e8 ed 00 00 00       	call   80105a60 <trap>
  addl $4, %esp
80105973:	83 c4 04             	add    $0x4,%esp

80105976 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105976:	61                   	popa   
  popl %gs
80105977:	0f a9                	pop    %gs
  popl %fs
80105979:	0f a1                	pop    %fs
  popl %es
8010597b:	07                   	pop    %es
  popl %ds
8010597c:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010597d:	83 c4 08             	add    $0x8,%esp
  iret
80105980:	cf                   	iret   
80105981:	66 90                	xchg   %ax,%ax
80105983:	66 90                	xchg   %ax,%ax
80105985:	66 90                	xchg   %ax,%ax
80105987:	66 90                	xchg   %ax,%ax
80105989:	66 90                	xchg   %ax,%ax
8010598b:	66 90                	xchg   %ax,%ax
8010598d:	66 90                	xchg   %ax,%ax
8010598f:	90                   	nop

80105990 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105990:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105991:	31 c0                	xor    %eax,%eax
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105993:	89 e5                	mov    %esp,%ebp
80105995:	83 ec 08             	sub    $0x8,%esp
80105998:	90                   	nop
80105999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801059a0:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
801059a7:	b9 08 00 00 00       	mov    $0x8,%ecx
801059ac:	c6 04 c5 a4 54 11 80 	movb   $0x0,-0x7feeab5c(,%eax,8)
801059b3:	00 
801059b4:	66 89 0c c5 a2 54 11 	mov    %cx,-0x7feeab5e(,%eax,8)
801059bb:	80 
801059bc:	c6 04 c5 a5 54 11 80 	movb   $0x8e,-0x7feeab5b(,%eax,8)
801059c3:	8e 
801059c4:	66 89 14 c5 a0 54 11 	mov    %dx,-0x7feeab60(,%eax,8)
801059cb:	80 
801059cc:	c1 ea 10             	shr    $0x10,%edx
801059cf:	66 89 14 c5 a6 54 11 	mov    %dx,-0x7feeab5a(,%eax,8)
801059d6:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801059d7:	83 c0 01             	add    $0x1,%eax
801059da:	3d 00 01 00 00       	cmp    $0x100,%eax
801059df:	75 bf                	jne    801059a0 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059e1:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
801059e6:	83 ec 08             	sub    $0x8,%esp
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059e9:	ba 08 00 00 00       	mov    $0x8,%edx

  initlock(&tickslock, "time");
801059ee:	68 df 79 10 80       	push   $0x801079df
801059f3:	68 60 54 11 80       	push   $0x80115460
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059f8:	66 89 15 a2 56 11 80 	mov    %dx,0x801156a2
801059ff:	c6 05 a4 56 11 80 00 	movb   $0x0,0x801156a4
80105a06:	66 a3 a0 56 11 80    	mov    %ax,0x801156a0
80105a0c:	c1 e8 10             	shr    $0x10,%eax
80105a0f:	c6 05 a5 56 11 80 ef 	movb   $0xef,0x801156a5
80105a16:	66 a3 a6 56 11 80    	mov    %ax,0x801156a6

  initlock(&tickslock, "time");
80105a1c:	e8 af e9 ff ff       	call   801043d0 <initlock>
}
80105a21:	83 c4 10             	add    $0x10,%esp
80105a24:	c9                   	leave  
80105a25:	c3                   	ret    
80105a26:	8d 76 00             	lea    0x0(%esi),%esi
80105a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a30 <idtinit>:

void
idtinit(void)
{
80105a30:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105a31:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a36:	89 e5                	mov    %esp,%ebp
80105a38:	83 ec 10             	sub    $0x10,%esp
80105a3b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a3f:	b8 a0 54 11 80       	mov    $0x801154a0,%eax
80105a44:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a48:	c1 e8 10             	shr    $0x10,%eax
80105a4b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105a4f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a52:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a55:	c9                   	leave  
80105a56:	c3                   	ret    
80105a57:	89 f6                	mov    %esi,%esi
80105a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a60 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	57                   	push   %edi
80105a64:	56                   	push   %esi
80105a65:	53                   	push   %ebx
80105a66:	83 ec 1c             	sub    $0x1c,%esp
80105a69:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105a6c:	8b 47 30             	mov    0x30(%edi),%eax
80105a6f:	83 f8 40             	cmp    $0x40,%eax
80105a72:	0f 84 88 01 00 00    	je     80105c00 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a78:	83 e8 20             	sub    $0x20,%eax
80105a7b:	83 f8 1f             	cmp    $0x1f,%eax
80105a7e:	77 10                	ja     80105a90 <trap+0x30>
80105a80:	ff 24 85 88 7a 10 80 	jmp    *-0x7fef8578(,%eax,4)
80105a87:	89 f6                	mov    %esi,%esi
80105a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a90:	e8 3b de ff ff       	call   801038d0 <myproc>
80105a95:	85 c0                	test   %eax,%eax
80105a97:	0f 84 d7 01 00 00    	je     80105c74 <trap+0x214>
80105a9d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105aa1:	0f 84 cd 01 00 00    	je     80105c74 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105aa7:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105aaa:	8b 57 38             	mov    0x38(%edi),%edx
80105aad:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105ab0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105ab3:	e8 f8 dd ff ff       	call   801038b0 <cpuid>
80105ab8:	8b 77 34             	mov    0x34(%edi),%esi
80105abb:	8b 5f 30             	mov    0x30(%edi),%ebx
80105abe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno, tf->err, cpuid(), tf->eip,
80105ac1:	e8 0a de ff ff       	call   801038d0 <myproc>
80105ac6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ac9:	e8 02 de ff ff       	call   801038d0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ace:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ad1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ad4:	51                   	push   %ecx
80105ad5:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno, tf->err, cpuid(), tf->eip,
80105ad6:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ad9:	ff 75 e4             	pushl  -0x1c(%ebp)
80105adc:	56                   	push   %esi
80105add:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno, tf->err, cpuid(), tf->eip,
80105ade:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ae1:	52                   	push   %edx
80105ae2:	ff 70 10             	pushl  0x10(%eax)
80105ae5:	68 44 7a 10 80       	push   $0x80107a44
80105aea:	e8 71 ab ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno, tf->err, cpuid(), tf->eip,
            rcr2());
    myproc()->killed = 1;
80105aef:	83 c4 20             	add    $0x20,%esp
80105af2:	e8 d9 dd ff ff       	call   801038d0 <myproc>
80105af7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105afe:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b00:	e8 cb dd ff ff       	call   801038d0 <myproc>
80105b05:	85 c0                	test   %eax,%eax
80105b07:	74 0c                	je     80105b15 <trap+0xb5>
80105b09:	e8 c2 dd ff ff       	call   801038d0 <myproc>
80105b0e:	8b 50 24             	mov    0x24(%eax),%edx
80105b11:	85 d2                	test   %edx,%edx
80105b13:	75 4b                	jne    80105b60 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105b15:	e8 b6 dd ff ff       	call   801038d0 <myproc>
80105b1a:	85 c0                	test   %eax,%eax
80105b1c:	74 0b                	je     80105b29 <trap+0xc9>
80105b1e:	e8 ad dd ff ff       	call   801038d0 <myproc>
80105b23:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b27:	74 4f                	je     80105b78 <trap+0x118>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b29:	e8 a2 dd ff ff       	call   801038d0 <myproc>
80105b2e:	85 c0                	test   %eax,%eax
80105b30:	74 1d                	je     80105b4f <trap+0xef>
80105b32:	e8 99 dd ff ff       	call   801038d0 <myproc>
80105b37:	8b 40 24             	mov    0x24(%eax),%eax
80105b3a:	85 c0                	test   %eax,%eax
80105b3c:	74 11                	je     80105b4f <trap+0xef>
80105b3e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b42:	83 e0 03             	and    $0x3,%eax
80105b45:	66 83 f8 03          	cmp    $0x3,%ax
80105b49:	0f 84 da 00 00 00    	je     80105c29 <trap+0x1c9>
    exit();
}
80105b4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b52:	5b                   	pop    %ebx
80105b53:	5e                   	pop    %esi
80105b54:	5f                   	pop    %edi
80105b55:	5d                   	pop    %ebp
80105b56:	c3                   	ret    
80105b57:	89 f6                	mov    %esi,%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b60:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105b64:	83 e0 03             	and    $0x3,%eax
80105b67:	66 83 f8 03          	cmp    $0x3,%ax
80105b6b:	75 a8                	jne    80105b15 <trap+0xb5>
    exit();
80105b6d:	e8 8e e1 ff ff       	call   80103d00 <exit>
80105b72:	eb a1                	jmp    80105b15 <trap+0xb5>
80105b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105b78:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105b7c:	75 ab                	jne    80105b29 <trap+0xc9>
    yield();
80105b7e:	e8 ad e2 ff ff       	call   80103e30 <yield>
80105b83:	eb a4                	jmp    80105b29 <trap+0xc9>
80105b85:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105b88:	e8 23 dd ff ff       	call   801038b0 <cpuid>
80105b8d:	85 c0                	test   %eax,%eax
80105b8f:	0f 84 ab 00 00 00    	je     80105c40 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105b95:	e8 86 cb ff ff       	call   80102720 <lapiceoi>
    break;
80105b9a:	e9 61 ff ff ff       	jmp    80105b00 <trap+0xa0>
80105b9f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105ba0:	e8 3b ca ff ff       	call   801025e0 <kbdintr>
    lapiceoi();
80105ba5:	e8 76 cb ff ff       	call   80102720 <lapiceoi>
    break;
80105baa:	e9 51 ff ff ff       	jmp    80105b00 <trap+0xa0>
80105baf:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105bb0:	e8 5b 02 00 00       	call   80105e10 <uartintr>
    lapiceoi();
80105bb5:	e8 66 cb ff ff       	call   80102720 <lapiceoi>
    break;
80105bba:	e9 41 ff ff ff       	jmp    80105b00 <trap+0xa0>
80105bbf:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105bc0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105bc4:	8b 77 38             	mov    0x38(%edi),%esi
80105bc7:	e8 e4 dc ff ff       	call   801038b0 <cpuid>
80105bcc:	56                   	push   %esi
80105bcd:	53                   	push   %ebx
80105bce:	50                   	push   %eax
80105bcf:	68 ec 79 10 80       	push   $0x801079ec
80105bd4:	e8 87 aa ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105bd9:	e8 42 cb ff ff       	call   80102720 <lapiceoi>
    break;
80105bde:	83 c4 10             	add    $0x10,%esp
80105be1:	e9 1a ff ff ff       	jmp    80105b00 <trap+0xa0>
80105be6:	8d 76 00             	lea    0x0(%esi),%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105bf0:	e8 4b c4 ff ff       	call   80102040 <ideintr>
80105bf5:	eb 9e                	jmp    80105b95 <trap+0x135>
80105bf7:	89 f6                	mov    %esi,%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105c00:	e8 cb dc ff ff       	call   801038d0 <myproc>
80105c05:	8b 58 24             	mov    0x24(%eax),%ebx
80105c08:	85 db                	test   %ebx,%ebx
80105c0a:	75 2c                	jne    80105c38 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105c0c:	e8 bf dc ff ff       	call   801038d0 <myproc>
80105c11:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105c14:	e8 07 ee ff ff       	call   80104a20 <syscall>
    if(myproc()->killed)
80105c19:	e8 b2 dc ff ff       	call   801038d0 <myproc>
80105c1e:	8b 48 24             	mov    0x24(%eax),%ecx
80105c21:	85 c9                	test   %ecx,%ecx
80105c23:	0f 84 26 ff ff ff    	je     80105b4f <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105c29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c2c:	5b                   	pop    %ebx
80105c2d:	5e                   	pop    %esi
80105c2e:	5f                   	pop    %edi
80105c2f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105c30:	e9 cb e0 ff ff       	jmp    80103d00 <exit>
80105c35:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105c38:	e8 c3 e0 ff ff       	call   80103d00 <exit>
80105c3d:	eb cd                	jmp    80105c0c <trap+0x1ac>
80105c3f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105c40:	83 ec 0c             	sub    $0xc,%esp
80105c43:	68 60 54 11 80       	push   $0x80115460
80105c48:	e8 83 e8 ff ff       	call   801044d0 <acquire>
      ticks++;
      wakeup(&ticks);
80105c4d:	c7 04 24 a0 5c 11 80 	movl   $0x80115ca0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105c54:	83 05 a0 5c 11 80 01 	addl   $0x1,0x80115ca0
      wakeup(&ticks);
80105c5b:	e8 e0 e3 ff ff       	call   80104040 <wakeup>
      release(&tickslock);
80105c60:	c7 04 24 60 54 11 80 	movl   $0x80115460,(%esp)
80105c67:	e8 84 e9 ff ff       	call   801045f0 <release>
80105c6c:	83 c4 10             	add    $0x10,%esp
80105c6f:	e9 21 ff ff ff       	jmp    80105b95 <trap+0x135>
80105c74:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c77:	8b 5f 38             	mov    0x38(%edi),%ebx
80105c7a:	e8 31 dc ff ff       	call   801038b0 <cpuid>
80105c7f:	83 ec 0c             	sub    $0xc,%esp
80105c82:	56                   	push   %esi
80105c83:	53                   	push   %ebx
80105c84:	50                   	push   %eax
80105c85:	ff 77 30             	pushl  0x30(%edi)
80105c88:	68 10 7a 10 80       	push   $0x80107a10
80105c8d:	e8 ce a9 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80105c92:	83 c4 14             	add    $0x14,%esp
80105c95:	68 e4 79 10 80       	push   $0x801079e4
80105c9a:	e8 d1 a6 ff ff       	call   80100370 <panic>
80105c9f:	90                   	nop

80105ca0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105ca0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105ca5:	55                   	push   %ebp
80105ca6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ca8:	85 c0                	test   %eax,%eax
80105caa:	74 1c                	je     80105cc8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cac:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cb1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105cb2:	a8 01                	test   $0x1,%al
80105cb4:	74 12                	je     80105cc8 <uartgetc+0x28>
80105cb6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cbb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105cbc:	0f b6 c0             	movzbl %al,%eax
}
80105cbf:	5d                   	pop    %ebp
80105cc0:	c3                   	ret    
80105cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105cc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105ccd:	5d                   	pop    %ebp
80105cce:	c3                   	ret    
80105ccf:	90                   	nop

80105cd0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	57                   	push   %edi
80105cd4:	56                   	push   %esi
80105cd5:	53                   	push   %ebx
80105cd6:	89 c7                	mov    %eax,%edi
80105cd8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105cdd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105ce2:	83 ec 0c             	sub    $0xc,%esp
80105ce5:	eb 1b                	jmp    80105d02 <uartputc.part.0+0x32>
80105ce7:	89 f6                	mov    %esi,%esi
80105ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105cf0:	83 ec 0c             	sub    $0xc,%esp
80105cf3:	6a 0a                	push   $0xa
80105cf5:	e8 46 ca ff ff       	call   80102740 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105cfa:	83 c4 10             	add    $0x10,%esp
80105cfd:	83 eb 01             	sub    $0x1,%ebx
80105d00:	74 07                	je     80105d09 <uartputc.part.0+0x39>
80105d02:	89 f2                	mov    %esi,%edx
80105d04:	ec                   	in     (%dx),%al
80105d05:	a8 20                	test   $0x20,%al
80105d07:	74 e7                	je     80105cf0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d09:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d0e:	89 f8                	mov    %edi,%eax
80105d10:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105d11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d14:	5b                   	pop    %ebx
80105d15:	5e                   	pop    %esi
80105d16:	5f                   	pop    %edi
80105d17:	5d                   	pop    %ebp
80105d18:	c3                   	ret    
80105d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d20 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105d20:	55                   	push   %ebp
80105d21:	31 c9                	xor    %ecx,%ecx
80105d23:	89 c8                	mov    %ecx,%eax
80105d25:	89 e5                	mov    %esp,%ebp
80105d27:	57                   	push   %edi
80105d28:	56                   	push   %esi
80105d29:	53                   	push   %ebx
80105d2a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105d2f:	89 da                	mov    %ebx,%edx
80105d31:	83 ec 0c             	sub    $0xc,%esp
80105d34:	ee                   	out    %al,(%dx)
80105d35:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105d3a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d3f:	89 fa                	mov    %edi,%edx
80105d41:	ee                   	out    %al,(%dx)
80105d42:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d47:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d4c:	ee                   	out    %al,(%dx)
80105d4d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105d52:	89 c8                	mov    %ecx,%eax
80105d54:	89 f2                	mov    %esi,%edx
80105d56:	ee                   	out    %al,(%dx)
80105d57:	b8 03 00 00 00       	mov    $0x3,%eax
80105d5c:	89 fa                	mov    %edi,%edx
80105d5e:	ee                   	out    %al,(%dx)
80105d5f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d64:	89 c8                	mov    %ecx,%eax
80105d66:	ee                   	out    %al,(%dx)
80105d67:	b8 01 00 00 00       	mov    $0x1,%eax
80105d6c:	89 f2                	mov    %esi,%edx
80105d6e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d6f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d74:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105d75:	3c ff                	cmp    $0xff,%al
80105d77:	74 5a                	je     80105dd3 <uartinit+0xb3>
    return;
  uart = 1;
80105d79:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105d80:	00 00 00 
80105d83:	89 da                	mov    %ebx,%edx
80105d85:	ec                   	in     (%dx),%al
80105d86:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d8b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
80105d8c:	83 ec 0c             	sub    $0xc,%esp
80105d8f:	6a 04                	push   $0x4
80105d91:	e8 7a d4 ff ff       	call   80103210 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105d96:	59                   	pop    %ecx
80105d97:	5b                   	pop    %ebx
80105d98:	6a 00                	push   $0x0
80105d9a:	6a 04                	push   $0x4
80105d9c:	bb 08 7b 10 80       	mov    $0x80107b08,%ebx
80105da1:	e8 fa c4 ff ff       	call   801022a0 <ioapicenable>
80105da6:	83 c4 10             	add    $0x10,%esp
80105da9:	b8 78 00 00 00       	mov    $0x78,%eax
80105dae:	eb 0a                	jmp    80105dba <uartinit+0x9a>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105db0:	83 c3 01             	add    $0x1,%ebx
80105db3:	0f be 03             	movsbl (%ebx),%eax
80105db6:	84 c0                	test   %al,%al
80105db8:	74 19                	je     80105dd3 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105dba:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105dc0:	85 d2                	test   %edx,%edx
80105dc2:	74 ec                	je     80105db0 <uartinit+0x90>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105dc4:	83 c3 01             	add    $0x1,%ebx
80105dc7:	e8 04 ff ff ff       	call   80105cd0 <uartputc.part.0>
80105dcc:	0f be 03             	movsbl (%ebx),%eax
80105dcf:	84 c0                	test   %al,%al
80105dd1:	75 e7                	jne    80105dba <uartinit+0x9a>
    uartputc(*p);
}
80105dd3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dd6:	5b                   	pop    %ebx
80105dd7:	5e                   	pop    %esi
80105dd8:	5f                   	pop    %edi
80105dd9:	5d                   	pop    %ebp
80105dda:	c3                   	ret    
80105ddb:	90                   	nop
80105ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105de0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105de0:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105de6:	55                   	push   %ebp
80105de7:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105de9:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105deb:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105dee:	74 10                	je     80105e00 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105df0:	5d                   	pop    %ebp
80105df1:	e9 da fe ff ff       	jmp    80105cd0 <uartputc.part.0>
80105df6:	8d 76 00             	lea    0x0(%esi),%esi
80105df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105e00:	5d                   	pop    %ebp
80105e01:	c3                   	ret    
80105e02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e10 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e16:	68 a0 5c 10 80       	push   $0x80105ca0
80105e1b:	e8 c0 a9 ff ff       	call   801007e0 <consoleintr>
}
80105e20:	83 c4 10             	add    $0x10,%esp
80105e23:	c9                   	leave  
80105e24:	c3                   	ret    

80105e25 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e25:	6a 00                	push   $0x0
  pushl $0
80105e27:	6a 00                	push   $0x0
  jmp alltraps
80105e29:	e9 30 fb ff ff       	jmp    8010595e <alltraps>

80105e2e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e2e:	6a 00                	push   $0x0
  pushl $1
80105e30:	6a 01                	push   $0x1
  jmp alltraps
80105e32:	e9 27 fb ff ff       	jmp    8010595e <alltraps>

80105e37 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e37:	6a 00                	push   $0x0
  pushl $2
80105e39:	6a 02                	push   $0x2
  jmp alltraps
80105e3b:	e9 1e fb ff ff       	jmp    8010595e <alltraps>

80105e40 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e40:	6a 00                	push   $0x0
  pushl $3
80105e42:	6a 03                	push   $0x3
  jmp alltraps
80105e44:	e9 15 fb ff ff       	jmp    8010595e <alltraps>

80105e49 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e49:	6a 00                	push   $0x0
  pushl $4
80105e4b:	6a 04                	push   $0x4
  jmp alltraps
80105e4d:	e9 0c fb ff ff       	jmp    8010595e <alltraps>

80105e52 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e52:	6a 00                	push   $0x0
  pushl $5
80105e54:	6a 05                	push   $0x5
  jmp alltraps
80105e56:	e9 03 fb ff ff       	jmp    8010595e <alltraps>

80105e5b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e5b:	6a 00                	push   $0x0
  pushl $6
80105e5d:	6a 06                	push   $0x6
  jmp alltraps
80105e5f:	e9 fa fa ff ff       	jmp    8010595e <alltraps>

80105e64 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e64:	6a 00                	push   $0x0
  pushl $7
80105e66:	6a 07                	push   $0x7
  jmp alltraps
80105e68:	e9 f1 fa ff ff       	jmp    8010595e <alltraps>

80105e6d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e6d:	6a 08                	push   $0x8
  jmp alltraps
80105e6f:	e9 ea fa ff ff       	jmp    8010595e <alltraps>

80105e74 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e74:	6a 00                	push   $0x0
  pushl $9
80105e76:	6a 09                	push   $0x9
  jmp alltraps
80105e78:	e9 e1 fa ff ff       	jmp    8010595e <alltraps>

80105e7d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e7d:	6a 0a                	push   $0xa
  jmp alltraps
80105e7f:	e9 da fa ff ff       	jmp    8010595e <alltraps>

80105e84 <vector11>:
.globl vector11
vector11:
  pushl $11
80105e84:	6a 0b                	push   $0xb
  jmp alltraps
80105e86:	e9 d3 fa ff ff       	jmp    8010595e <alltraps>

80105e8b <vector12>:
.globl vector12
vector12:
  pushl $12
80105e8b:	6a 0c                	push   $0xc
  jmp alltraps
80105e8d:	e9 cc fa ff ff       	jmp    8010595e <alltraps>

80105e92 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e92:	6a 0d                	push   $0xd
  jmp alltraps
80105e94:	e9 c5 fa ff ff       	jmp    8010595e <alltraps>

80105e99 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e99:	6a 0e                	push   $0xe
  jmp alltraps
80105e9b:	e9 be fa ff ff       	jmp    8010595e <alltraps>

80105ea0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105ea0:	6a 00                	push   $0x0
  pushl $15
80105ea2:	6a 0f                	push   $0xf
  jmp alltraps
80105ea4:	e9 b5 fa ff ff       	jmp    8010595e <alltraps>

80105ea9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105ea9:	6a 00                	push   $0x0
  pushl $16
80105eab:	6a 10                	push   $0x10
  jmp alltraps
80105ead:	e9 ac fa ff ff       	jmp    8010595e <alltraps>

80105eb2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105eb2:	6a 11                	push   $0x11
  jmp alltraps
80105eb4:	e9 a5 fa ff ff       	jmp    8010595e <alltraps>

80105eb9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105eb9:	6a 00                	push   $0x0
  pushl $18
80105ebb:	6a 12                	push   $0x12
  jmp alltraps
80105ebd:	e9 9c fa ff ff       	jmp    8010595e <alltraps>

80105ec2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105ec2:	6a 00                	push   $0x0
  pushl $19
80105ec4:	6a 13                	push   $0x13
  jmp alltraps
80105ec6:	e9 93 fa ff ff       	jmp    8010595e <alltraps>

80105ecb <vector20>:
.globl vector20
vector20:
  pushl $0
80105ecb:	6a 00                	push   $0x0
  pushl $20
80105ecd:	6a 14                	push   $0x14
  jmp alltraps
80105ecf:	e9 8a fa ff ff       	jmp    8010595e <alltraps>

80105ed4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105ed4:	6a 00                	push   $0x0
  pushl $21
80105ed6:	6a 15                	push   $0x15
  jmp alltraps
80105ed8:	e9 81 fa ff ff       	jmp    8010595e <alltraps>

80105edd <vector22>:
.globl vector22
vector22:
  pushl $0
80105edd:	6a 00                	push   $0x0
  pushl $22
80105edf:	6a 16                	push   $0x16
  jmp alltraps
80105ee1:	e9 78 fa ff ff       	jmp    8010595e <alltraps>

80105ee6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105ee6:	6a 00                	push   $0x0
  pushl $23
80105ee8:	6a 17                	push   $0x17
  jmp alltraps
80105eea:	e9 6f fa ff ff       	jmp    8010595e <alltraps>

80105eef <vector24>:
.globl vector24
vector24:
  pushl $0
80105eef:	6a 00                	push   $0x0
  pushl $24
80105ef1:	6a 18                	push   $0x18
  jmp alltraps
80105ef3:	e9 66 fa ff ff       	jmp    8010595e <alltraps>

80105ef8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ef8:	6a 00                	push   $0x0
  pushl $25
80105efa:	6a 19                	push   $0x19
  jmp alltraps
80105efc:	e9 5d fa ff ff       	jmp    8010595e <alltraps>

80105f01 <vector26>:
.globl vector26
vector26:
  pushl $0
80105f01:	6a 00                	push   $0x0
  pushl $26
80105f03:	6a 1a                	push   $0x1a
  jmp alltraps
80105f05:	e9 54 fa ff ff       	jmp    8010595e <alltraps>

80105f0a <vector27>:
.globl vector27
vector27:
  pushl $0
80105f0a:	6a 00                	push   $0x0
  pushl $27
80105f0c:	6a 1b                	push   $0x1b
  jmp alltraps
80105f0e:	e9 4b fa ff ff       	jmp    8010595e <alltraps>

80105f13 <vector28>:
.globl vector28
vector28:
  pushl $0
80105f13:	6a 00                	push   $0x0
  pushl $28
80105f15:	6a 1c                	push   $0x1c
  jmp alltraps
80105f17:	e9 42 fa ff ff       	jmp    8010595e <alltraps>

80105f1c <vector29>:
.globl vector29
vector29:
  pushl $0
80105f1c:	6a 00                	push   $0x0
  pushl $29
80105f1e:	6a 1d                	push   $0x1d
  jmp alltraps
80105f20:	e9 39 fa ff ff       	jmp    8010595e <alltraps>

80105f25 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f25:	6a 00                	push   $0x0
  pushl $30
80105f27:	6a 1e                	push   $0x1e
  jmp alltraps
80105f29:	e9 30 fa ff ff       	jmp    8010595e <alltraps>

80105f2e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f2e:	6a 00                	push   $0x0
  pushl $31
80105f30:	6a 1f                	push   $0x1f
  jmp alltraps
80105f32:	e9 27 fa ff ff       	jmp    8010595e <alltraps>

80105f37 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f37:	6a 00                	push   $0x0
  pushl $32
80105f39:	6a 20                	push   $0x20
  jmp alltraps
80105f3b:	e9 1e fa ff ff       	jmp    8010595e <alltraps>

80105f40 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f40:	6a 00                	push   $0x0
  pushl $33
80105f42:	6a 21                	push   $0x21
  jmp alltraps
80105f44:	e9 15 fa ff ff       	jmp    8010595e <alltraps>

80105f49 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f49:	6a 00                	push   $0x0
  pushl $34
80105f4b:	6a 22                	push   $0x22
  jmp alltraps
80105f4d:	e9 0c fa ff ff       	jmp    8010595e <alltraps>

80105f52 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f52:	6a 00                	push   $0x0
  pushl $35
80105f54:	6a 23                	push   $0x23
  jmp alltraps
80105f56:	e9 03 fa ff ff       	jmp    8010595e <alltraps>

80105f5b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f5b:	6a 00                	push   $0x0
  pushl $36
80105f5d:	6a 24                	push   $0x24
  jmp alltraps
80105f5f:	e9 fa f9 ff ff       	jmp    8010595e <alltraps>

80105f64 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f64:	6a 00                	push   $0x0
  pushl $37
80105f66:	6a 25                	push   $0x25
  jmp alltraps
80105f68:	e9 f1 f9 ff ff       	jmp    8010595e <alltraps>

80105f6d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f6d:	6a 00                	push   $0x0
  pushl $38
80105f6f:	6a 26                	push   $0x26
  jmp alltraps
80105f71:	e9 e8 f9 ff ff       	jmp    8010595e <alltraps>

80105f76 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f76:	6a 00                	push   $0x0
  pushl $39
80105f78:	6a 27                	push   $0x27
  jmp alltraps
80105f7a:	e9 df f9 ff ff       	jmp    8010595e <alltraps>

80105f7f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f7f:	6a 00                	push   $0x0
  pushl $40
80105f81:	6a 28                	push   $0x28
  jmp alltraps
80105f83:	e9 d6 f9 ff ff       	jmp    8010595e <alltraps>

80105f88 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f88:	6a 00                	push   $0x0
  pushl $41
80105f8a:	6a 29                	push   $0x29
  jmp alltraps
80105f8c:	e9 cd f9 ff ff       	jmp    8010595e <alltraps>

80105f91 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f91:	6a 00                	push   $0x0
  pushl $42
80105f93:	6a 2a                	push   $0x2a
  jmp alltraps
80105f95:	e9 c4 f9 ff ff       	jmp    8010595e <alltraps>

80105f9a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f9a:	6a 00                	push   $0x0
  pushl $43
80105f9c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f9e:	e9 bb f9 ff ff       	jmp    8010595e <alltraps>

80105fa3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105fa3:	6a 00                	push   $0x0
  pushl $44
80105fa5:	6a 2c                	push   $0x2c
  jmp alltraps
80105fa7:	e9 b2 f9 ff ff       	jmp    8010595e <alltraps>

80105fac <vector45>:
.globl vector45
vector45:
  pushl $0
80105fac:	6a 00                	push   $0x0
  pushl $45
80105fae:	6a 2d                	push   $0x2d
  jmp alltraps
80105fb0:	e9 a9 f9 ff ff       	jmp    8010595e <alltraps>

80105fb5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105fb5:	6a 00                	push   $0x0
  pushl $46
80105fb7:	6a 2e                	push   $0x2e
  jmp alltraps
80105fb9:	e9 a0 f9 ff ff       	jmp    8010595e <alltraps>

80105fbe <vector47>:
.globl vector47
vector47:
  pushl $0
80105fbe:	6a 00                	push   $0x0
  pushl $47
80105fc0:	6a 2f                	push   $0x2f
  jmp alltraps
80105fc2:	e9 97 f9 ff ff       	jmp    8010595e <alltraps>

80105fc7 <vector48>:
.globl vector48
vector48:
  pushl $0
80105fc7:	6a 00                	push   $0x0
  pushl $48
80105fc9:	6a 30                	push   $0x30
  jmp alltraps
80105fcb:	e9 8e f9 ff ff       	jmp    8010595e <alltraps>

80105fd0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105fd0:	6a 00                	push   $0x0
  pushl $49
80105fd2:	6a 31                	push   $0x31
  jmp alltraps
80105fd4:	e9 85 f9 ff ff       	jmp    8010595e <alltraps>

80105fd9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105fd9:	6a 00                	push   $0x0
  pushl $50
80105fdb:	6a 32                	push   $0x32
  jmp alltraps
80105fdd:	e9 7c f9 ff ff       	jmp    8010595e <alltraps>

80105fe2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105fe2:	6a 00                	push   $0x0
  pushl $51
80105fe4:	6a 33                	push   $0x33
  jmp alltraps
80105fe6:	e9 73 f9 ff ff       	jmp    8010595e <alltraps>

80105feb <vector52>:
.globl vector52
vector52:
  pushl $0
80105feb:	6a 00                	push   $0x0
  pushl $52
80105fed:	6a 34                	push   $0x34
  jmp alltraps
80105fef:	e9 6a f9 ff ff       	jmp    8010595e <alltraps>

80105ff4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105ff4:	6a 00                	push   $0x0
  pushl $53
80105ff6:	6a 35                	push   $0x35
  jmp alltraps
80105ff8:	e9 61 f9 ff ff       	jmp    8010595e <alltraps>

80105ffd <vector54>:
.globl vector54
vector54:
  pushl $0
80105ffd:	6a 00                	push   $0x0
  pushl $54
80105fff:	6a 36                	push   $0x36
  jmp alltraps
80106001:	e9 58 f9 ff ff       	jmp    8010595e <alltraps>

80106006 <vector55>:
.globl vector55
vector55:
  pushl $0
80106006:	6a 00                	push   $0x0
  pushl $55
80106008:	6a 37                	push   $0x37
  jmp alltraps
8010600a:	e9 4f f9 ff ff       	jmp    8010595e <alltraps>

8010600f <vector56>:
.globl vector56
vector56:
  pushl $0
8010600f:	6a 00                	push   $0x0
  pushl $56
80106011:	6a 38                	push   $0x38
  jmp alltraps
80106013:	e9 46 f9 ff ff       	jmp    8010595e <alltraps>

80106018 <vector57>:
.globl vector57
vector57:
  pushl $0
80106018:	6a 00                	push   $0x0
  pushl $57
8010601a:	6a 39                	push   $0x39
  jmp alltraps
8010601c:	e9 3d f9 ff ff       	jmp    8010595e <alltraps>

80106021 <vector58>:
.globl vector58
vector58:
  pushl $0
80106021:	6a 00                	push   $0x0
  pushl $58
80106023:	6a 3a                	push   $0x3a
  jmp alltraps
80106025:	e9 34 f9 ff ff       	jmp    8010595e <alltraps>

8010602a <vector59>:
.globl vector59
vector59:
  pushl $0
8010602a:	6a 00                	push   $0x0
  pushl $59
8010602c:	6a 3b                	push   $0x3b
  jmp alltraps
8010602e:	e9 2b f9 ff ff       	jmp    8010595e <alltraps>

80106033 <vector60>:
.globl vector60
vector60:
  pushl $0
80106033:	6a 00                	push   $0x0
  pushl $60
80106035:	6a 3c                	push   $0x3c
  jmp alltraps
80106037:	e9 22 f9 ff ff       	jmp    8010595e <alltraps>

8010603c <vector61>:
.globl vector61
vector61:
  pushl $0
8010603c:	6a 00                	push   $0x0
  pushl $61
8010603e:	6a 3d                	push   $0x3d
  jmp alltraps
80106040:	e9 19 f9 ff ff       	jmp    8010595e <alltraps>

80106045 <vector62>:
.globl vector62
vector62:
  pushl $0
80106045:	6a 00                	push   $0x0
  pushl $62
80106047:	6a 3e                	push   $0x3e
  jmp alltraps
80106049:	e9 10 f9 ff ff       	jmp    8010595e <alltraps>

8010604e <vector63>:
.globl vector63
vector63:
  pushl $0
8010604e:	6a 00                	push   $0x0
  pushl $63
80106050:	6a 3f                	push   $0x3f
  jmp alltraps
80106052:	e9 07 f9 ff ff       	jmp    8010595e <alltraps>

80106057 <vector64>:
.globl vector64
vector64:
  pushl $0
80106057:	6a 00                	push   $0x0
  pushl $64
80106059:	6a 40                	push   $0x40
  jmp alltraps
8010605b:	e9 fe f8 ff ff       	jmp    8010595e <alltraps>

80106060 <vector65>:
.globl vector65
vector65:
  pushl $0
80106060:	6a 00                	push   $0x0
  pushl $65
80106062:	6a 41                	push   $0x41
  jmp alltraps
80106064:	e9 f5 f8 ff ff       	jmp    8010595e <alltraps>

80106069 <vector66>:
.globl vector66
vector66:
  pushl $0
80106069:	6a 00                	push   $0x0
  pushl $66
8010606b:	6a 42                	push   $0x42
  jmp alltraps
8010606d:	e9 ec f8 ff ff       	jmp    8010595e <alltraps>

80106072 <vector67>:
.globl vector67
vector67:
  pushl $0
80106072:	6a 00                	push   $0x0
  pushl $67
80106074:	6a 43                	push   $0x43
  jmp alltraps
80106076:	e9 e3 f8 ff ff       	jmp    8010595e <alltraps>

8010607b <vector68>:
.globl vector68
vector68:
  pushl $0
8010607b:	6a 00                	push   $0x0
  pushl $68
8010607d:	6a 44                	push   $0x44
  jmp alltraps
8010607f:	e9 da f8 ff ff       	jmp    8010595e <alltraps>

80106084 <vector69>:
.globl vector69
vector69:
  pushl $0
80106084:	6a 00                	push   $0x0
  pushl $69
80106086:	6a 45                	push   $0x45
  jmp alltraps
80106088:	e9 d1 f8 ff ff       	jmp    8010595e <alltraps>

8010608d <vector70>:
.globl vector70
vector70:
  pushl $0
8010608d:	6a 00                	push   $0x0
  pushl $70
8010608f:	6a 46                	push   $0x46
  jmp alltraps
80106091:	e9 c8 f8 ff ff       	jmp    8010595e <alltraps>

80106096 <vector71>:
.globl vector71
vector71:
  pushl $0
80106096:	6a 00                	push   $0x0
  pushl $71
80106098:	6a 47                	push   $0x47
  jmp alltraps
8010609a:	e9 bf f8 ff ff       	jmp    8010595e <alltraps>

8010609f <vector72>:
.globl vector72
vector72:
  pushl $0
8010609f:	6a 00                	push   $0x0
  pushl $72
801060a1:	6a 48                	push   $0x48
  jmp alltraps
801060a3:	e9 b6 f8 ff ff       	jmp    8010595e <alltraps>

801060a8 <vector73>:
.globl vector73
vector73:
  pushl $0
801060a8:	6a 00                	push   $0x0
  pushl $73
801060aa:	6a 49                	push   $0x49
  jmp alltraps
801060ac:	e9 ad f8 ff ff       	jmp    8010595e <alltraps>

801060b1 <vector74>:
.globl vector74
vector74:
  pushl $0
801060b1:	6a 00                	push   $0x0
  pushl $74
801060b3:	6a 4a                	push   $0x4a
  jmp alltraps
801060b5:	e9 a4 f8 ff ff       	jmp    8010595e <alltraps>

801060ba <vector75>:
.globl vector75
vector75:
  pushl $0
801060ba:	6a 00                	push   $0x0
  pushl $75
801060bc:	6a 4b                	push   $0x4b
  jmp alltraps
801060be:	e9 9b f8 ff ff       	jmp    8010595e <alltraps>

801060c3 <vector76>:
.globl vector76
vector76:
  pushl $0
801060c3:	6a 00                	push   $0x0
  pushl $76
801060c5:	6a 4c                	push   $0x4c
  jmp alltraps
801060c7:	e9 92 f8 ff ff       	jmp    8010595e <alltraps>

801060cc <vector77>:
.globl vector77
vector77:
  pushl $0
801060cc:	6a 00                	push   $0x0
  pushl $77
801060ce:	6a 4d                	push   $0x4d
  jmp alltraps
801060d0:	e9 89 f8 ff ff       	jmp    8010595e <alltraps>

801060d5 <vector78>:
.globl vector78
vector78:
  pushl $0
801060d5:	6a 00                	push   $0x0
  pushl $78
801060d7:	6a 4e                	push   $0x4e
  jmp alltraps
801060d9:	e9 80 f8 ff ff       	jmp    8010595e <alltraps>

801060de <vector79>:
.globl vector79
vector79:
  pushl $0
801060de:	6a 00                	push   $0x0
  pushl $79
801060e0:	6a 4f                	push   $0x4f
  jmp alltraps
801060e2:	e9 77 f8 ff ff       	jmp    8010595e <alltraps>

801060e7 <vector80>:
.globl vector80
vector80:
  pushl $0
801060e7:	6a 00                	push   $0x0
  pushl $80
801060e9:	6a 50                	push   $0x50
  jmp alltraps
801060eb:	e9 6e f8 ff ff       	jmp    8010595e <alltraps>

801060f0 <vector81>:
.globl vector81
vector81:
  pushl $0
801060f0:	6a 00                	push   $0x0
  pushl $81
801060f2:	6a 51                	push   $0x51
  jmp alltraps
801060f4:	e9 65 f8 ff ff       	jmp    8010595e <alltraps>

801060f9 <vector82>:
.globl vector82
vector82:
  pushl $0
801060f9:	6a 00                	push   $0x0
  pushl $82
801060fb:	6a 52                	push   $0x52
  jmp alltraps
801060fd:	e9 5c f8 ff ff       	jmp    8010595e <alltraps>

80106102 <vector83>:
.globl vector83
vector83:
  pushl $0
80106102:	6a 00                	push   $0x0
  pushl $83
80106104:	6a 53                	push   $0x53
  jmp alltraps
80106106:	e9 53 f8 ff ff       	jmp    8010595e <alltraps>

8010610b <vector84>:
.globl vector84
vector84:
  pushl $0
8010610b:	6a 00                	push   $0x0
  pushl $84
8010610d:	6a 54                	push   $0x54
  jmp alltraps
8010610f:	e9 4a f8 ff ff       	jmp    8010595e <alltraps>

80106114 <vector85>:
.globl vector85
vector85:
  pushl $0
80106114:	6a 00                	push   $0x0
  pushl $85
80106116:	6a 55                	push   $0x55
  jmp alltraps
80106118:	e9 41 f8 ff ff       	jmp    8010595e <alltraps>

8010611d <vector86>:
.globl vector86
vector86:
  pushl $0
8010611d:	6a 00                	push   $0x0
  pushl $86
8010611f:	6a 56                	push   $0x56
  jmp alltraps
80106121:	e9 38 f8 ff ff       	jmp    8010595e <alltraps>

80106126 <vector87>:
.globl vector87
vector87:
  pushl $0
80106126:	6a 00                	push   $0x0
  pushl $87
80106128:	6a 57                	push   $0x57
  jmp alltraps
8010612a:	e9 2f f8 ff ff       	jmp    8010595e <alltraps>

8010612f <vector88>:
.globl vector88
vector88:
  pushl $0
8010612f:	6a 00                	push   $0x0
  pushl $88
80106131:	6a 58                	push   $0x58
  jmp alltraps
80106133:	e9 26 f8 ff ff       	jmp    8010595e <alltraps>

80106138 <vector89>:
.globl vector89
vector89:
  pushl $0
80106138:	6a 00                	push   $0x0
  pushl $89
8010613a:	6a 59                	push   $0x59
  jmp alltraps
8010613c:	e9 1d f8 ff ff       	jmp    8010595e <alltraps>

80106141 <vector90>:
.globl vector90
vector90:
  pushl $0
80106141:	6a 00                	push   $0x0
  pushl $90
80106143:	6a 5a                	push   $0x5a
  jmp alltraps
80106145:	e9 14 f8 ff ff       	jmp    8010595e <alltraps>

8010614a <vector91>:
.globl vector91
vector91:
  pushl $0
8010614a:	6a 00                	push   $0x0
  pushl $91
8010614c:	6a 5b                	push   $0x5b
  jmp alltraps
8010614e:	e9 0b f8 ff ff       	jmp    8010595e <alltraps>

80106153 <vector92>:
.globl vector92
vector92:
  pushl $0
80106153:	6a 00                	push   $0x0
  pushl $92
80106155:	6a 5c                	push   $0x5c
  jmp alltraps
80106157:	e9 02 f8 ff ff       	jmp    8010595e <alltraps>

8010615c <vector93>:
.globl vector93
vector93:
  pushl $0
8010615c:	6a 00                	push   $0x0
  pushl $93
8010615e:	6a 5d                	push   $0x5d
  jmp alltraps
80106160:	e9 f9 f7 ff ff       	jmp    8010595e <alltraps>

80106165 <vector94>:
.globl vector94
vector94:
  pushl $0
80106165:	6a 00                	push   $0x0
  pushl $94
80106167:	6a 5e                	push   $0x5e
  jmp alltraps
80106169:	e9 f0 f7 ff ff       	jmp    8010595e <alltraps>

8010616e <vector95>:
.globl vector95
vector95:
  pushl $0
8010616e:	6a 00                	push   $0x0
  pushl $95
80106170:	6a 5f                	push   $0x5f
  jmp alltraps
80106172:	e9 e7 f7 ff ff       	jmp    8010595e <alltraps>

80106177 <vector96>:
.globl vector96
vector96:
  pushl $0
80106177:	6a 00                	push   $0x0
  pushl $96
80106179:	6a 60                	push   $0x60
  jmp alltraps
8010617b:	e9 de f7 ff ff       	jmp    8010595e <alltraps>

80106180 <vector97>:
.globl vector97
vector97:
  pushl $0
80106180:	6a 00                	push   $0x0
  pushl $97
80106182:	6a 61                	push   $0x61
  jmp alltraps
80106184:	e9 d5 f7 ff ff       	jmp    8010595e <alltraps>

80106189 <vector98>:
.globl vector98
vector98:
  pushl $0
80106189:	6a 00                	push   $0x0
  pushl $98
8010618b:	6a 62                	push   $0x62
  jmp alltraps
8010618d:	e9 cc f7 ff ff       	jmp    8010595e <alltraps>

80106192 <vector99>:
.globl vector99
vector99:
  pushl $0
80106192:	6a 00                	push   $0x0
  pushl $99
80106194:	6a 63                	push   $0x63
  jmp alltraps
80106196:	e9 c3 f7 ff ff       	jmp    8010595e <alltraps>

8010619b <vector100>:
.globl vector100
vector100:
  pushl $0
8010619b:	6a 00                	push   $0x0
  pushl $100
8010619d:	6a 64                	push   $0x64
  jmp alltraps
8010619f:	e9 ba f7 ff ff       	jmp    8010595e <alltraps>

801061a4 <vector101>:
.globl vector101
vector101:
  pushl $0
801061a4:	6a 00                	push   $0x0
  pushl $101
801061a6:	6a 65                	push   $0x65
  jmp alltraps
801061a8:	e9 b1 f7 ff ff       	jmp    8010595e <alltraps>

801061ad <vector102>:
.globl vector102
vector102:
  pushl $0
801061ad:	6a 00                	push   $0x0
  pushl $102
801061af:	6a 66                	push   $0x66
  jmp alltraps
801061b1:	e9 a8 f7 ff ff       	jmp    8010595e <alltraps>

801061b6 <vector103>:
.globl vector103
vector103:
  pushl $0
801061b6:	6a 00                	push   $0x0
  pushl $103
801061b8:	6a 67                	push   $0x67
  jmp alltraps
801061ba:	e9 9f f7 ff ff       	jmp    8010595e <alltraps>

801061bf <vector104>:
.globl vector104
vector104:
  pushl $0
801061bf:	6a 00                	push   $0x0
  pushl $104
801061c1:	6a 68                	push   $0x68
  jmp alltraps
801061c3:	e9 96 f7 ff ff       	jmp    8010595e <alltraps>

801061c8 <vector105>:
.globl vector105
vector105:
  pushl $0
801061c8:	6a 00                	push   $0x0
  pushl $105
801061ca:	6a 69                	push   $0x69
  jmp alltraps
801061cc:	e9 8d f7 ff ff       	jmp    8010595e <alltraps>

801061d1 <vector106>:
.globl vector106
vector106:
  pushl $0
801061d1:	6a 00                	push   $0x0
  pushl $106
801061d3:	6a 6a                	push   $0x6a
  jmp alltraps
801061d5:	e9 84 f7 ff ff       	jmp    8010595e <alltraps>

801061da <vector107>:
.globl vector107
vector107:
  pushl $0
801061da:	6a 00                	push   $0x0
  pushl $107
801061dc:	6a 6b                	push   $0x6b
  jmp alltraps
801061de:	e9 7b f7 ff ff       	jmp    8010595e <alltraps>

801061e3 <vector108>:
.globl vector108
vector108:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $108
801061e5:	6a 6c                	push   $0x6c
  jmp alltraps
801061e7:	e9 72 f7 ff ff       	jmp    8010595e <alltraps>

801061ec <vector109>:
.globl vector109
vector109:
  pushl $0
801061ec:	6a 00                	push   $0x0
  pushl $109
801061ee:	6a 6d                	push   $0x6d
  jmp alltraps
801061f0:	e9 69 f7 ff ff       	jmp    8010595e <alltraps>

801061f5 <vector110>:
.globl vector110
vector110:
  pushl $0
801061f5:	6a 00                	push   $0x0
  pushl $110
801061f7:	6a 6e                	push   $0x6e
  jmp alltraps
801061f9:	e9 60 f7 ff ff       	jmp    8010595e <alltraps>

801061fe <vector111>:
.globl vector111
vector111:
  pushl $0
801061fe:	6a 00                	push   $0x0
  pushl $111
80106200:	6a 6f                	push   $0x6f
  jmp alltraps
80106202:	e9 57 f7 ff ff       	jmp    8010595e <alltraps>

80106207 <vector112>:
.globl vector112
vector112:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $112
80106209:	6a 70                	push   $0x70
  jmp alltraps
8010620b:	e9 4e f7 ff ff       	jmp    8010595e <alltraps>

80106210 <vector113>:
.globl vector113
vector113:
  pushl $0
80106210:	6a 00                	push   $0x0
  pushl $113
80106212:	6a 71                	push   $0x71
  jmp alltraps
80106214:	e9 45 f7 ff ff       	jmp    8010595e <alltraps>

80106219 <vector114>:
.globl vector114
vector114:
  pushl $0
80106219:	6a 00                	push   $0x0
  pushl $114
8010621b:	6a 72                	push   $0x72
  jmp alltraps
8010621d:	e9 3c f7 ff ff       	jmp    8010595e <alltraps>

80106222 <vector115>:
.globl vector115
vector115:
  pushl $0
80106222:	6a 00                	push   $0x0
  pushl $115
80106224:	6a 73                	push   $0x73
  jmp alltraps
80106226:	e9 33 f7 ff ff       	jmp    8010595e <alltraps>

8010622b <vector116>:
.globl vector116
vector116:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $116
8010622d:	6a 74                	push   $0x74
  jmp alltraps
8010622f:	e9 2a f7 ff ff       	jmp    8010595e <alltraps>

80106234 <vector117>:
.globl vector117
vector117:
  pushl $0
80106234:	6a 00                	push   $0x0
  pushl $117
80106236:	6a 75                	push   $0x75
  jmp alltraps
80106238:	e9 21 f7 ff ff       	jmp    8010595e <alltraps>

8010623d <vector118>:
.globl vector118
vector118:
  pushl $0
8010623d:	6a 00                	push   $0x0
  pushl $118
8010623f:	6a 76                	push   $0x76
  jmp alltraps
80106241:	e9 18 f7 ff ff       	jmp    8010595e <alltraps>

80106246 <vector119>:
.globl vector119
vector119:
  pushl $0
80106246:	6a 00                	push   $0x0
  pushl $119
80106248:	6a 77                	push   $0x77
  jmp alltraps
8010624a:	e9 0f f7 ff ff       	jmp    8010595e <alltraps>

8010624f <vector120>:
.globl vector120
vector120:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $120
80106251:	6a 78                	push   $0x78
  jmp alltraps
80106253:	e9 06 f7 ff ff       	jmp    8010595e <alltraps>

80106258 <vector121>:
.globl vector121
vector121:
  pushl $0
80106258:	6a 00                	push   $0x0
  pushl $121
8010625a:	6a 79                	push   $0x79
  jmp alltraps
8010625c:	e9 fd f6 ff ff       	jmp    8010595e <alltraps>

80106261 <vector122>:
.globl vector122
vector122:
  pushl $0
80106261:	6a 00                	push   $0x0
  pushl $122
80106263:	6a 7a                	push   $0x7a
  jmp alltraps
80106265:	e9 f4 f6 ff ff       	jmp    8010595e <alltraps>

8010626a <vector123>:
.globl vector123
vector123:
  pushl $0
8010626a:	6a 00                	push   $0x0
  pushl $123
8010626c:	6a 7b                	push   $0x7b
  jmp alltraps
8010626e:	e9 eb f6 ff ff       	jmp    8010595e <alltraps>

80106273 <vector124>:
.globl vector124
vector124:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $124
80106275:	6a 7c                	push   $0x7c
  jmp alltraps
80106277:	e9 e2 f6 ff ff       	jmp    8010595e <alltraps>

8010627c <vector125>:
.globl vector125
vector125:
  pushl $0
8010627c:	6a 00                	push   $0x0
  pushl $125
8010627e:	6a 7d                	push   $0x7d
  jmp alltraps
80106280:	e9 d9 f6 ff ff       	jmp    8010595e <alltraps>

80106285 <vector126>:
.globl vector126
vector126:
  pushl $0
80106285:	6a 00                	push   $0x0
  pushl $126
80106287:	6a 7e                	push   $0x7e
  jmp alltraps
80106289:	e9 d0 f6 ff ff       	jmp    8010595e <alltraps>

8010628e <vector127>:
.globl vector127
vector127:
  pushl $0
8010628e:	6a 00                	push   $0x0
  pushl $127
80106290:	6a 7f                	push   $0x7f
  jmp alltraps
80106292:	e9 c7 f6 ff ff       	jmp    8010595e <alltraps>

80106297 <vector128>:
.globl vector128
vector128:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $128
80106299:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010629e:	e9 bb f6 ff ff       	jmp    8010595e <alltraps>

801062a3 <vector129>:
.globl vector129
vector129:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $129
801062a5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801062aa:	e9 af f6 ff ff       	jmp    8010595e <alltraps>

801062af <vector130>:
.globl vector130
vector130:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $130
801062b1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801062b6:	e9 a3 f6 ff ff       	jmp    8010595e <alltraps>

801062bb <vector131>:
.globl vector131
vector131:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $131
801062bd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801062c2:	e9 97 f6 ff ff       	jmp    8010595e <alltraps>

801062c7 <vector132>:
.globl vector132
vector132:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $132
801062c9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801062ce:	e9 8b f6 ff ff       	jmp    8010595e <alltraps>

801062d3 <vector133>:
.globl vector133
vector133:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $133
801062d5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062da:	e9 7f f6 ff ff       	jmp    8010595e <alltraps>

801062df <vector134>:
.globl vector134
vector134:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $134
801062e1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801062e6:	e9 73 f6 ff ff       	jmp    8010595e <alltraps>

801062eb <vector135>:
.globl vector135
vector135:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $135
801062ed:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801062f2:	e9 67 f6 ff ff       	jmp    8010595e <alltraps>

801062f7 <vector136>:
.globl vector136
vector136:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $136
801062f9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801062fe:	e9 5b f6 ff ff       	jmp    8010595e <alltraps>

80106303 <vector137>:
.globl vector137
vector137:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $137
80106305:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010630a:	e9 4f f6 ff ff       	jmp    8010595e <alltraps>

8010630f <vector138>:
.globl vector138
vector138:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $138
80106311:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106316:	e9 43 f6 ff ff       	jmp    8010595e <alltraps>

8010631b <vector139>:
.globl vector139
vector139:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $139
8010631d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106322:	e9 37 f6 ff ff       	jmp    8010595e <alltraps>

80106327 <vector140>:
.globl vector140
vector140:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $140
80106329:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010632e:	e9 2b f6 ff ff       	jmp    8010595e <alltraps>

80106333 <vector141>:
.globl vector141
vector141:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $141
80106335:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010633a:	e9 1f f6 ff ff       	jmp    8010595e <alltraps>

8010633f <vector142>:
.globl vector142
vector142:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $142
80106341:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106346:	e9 13 f6 ff ff       	jmp    8010595e <alltraps>

8010634b <vector143>:
.globl vector143
vector143:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $143
8010634d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106352:	e9 07 f6 ff ff       	jmp    8010595e <alltraps>

80106357 <vector144>:
.globl vector144
vector144:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $144
80106359:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010635e:	e9 fb f5 ff ff       	jmp    8010595e <alltraps>

80106363 <vector145>:
.globl vector145
vector145:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $145
80106365:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010636a:	e9 ef f5 ff ff       	jmp    8010595e <alltraps>

8010636f <vector146>:
.globl vector146
vector146:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $146
80106371:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106376:	e9 e3 f5 ff ff       	jmp    8010595e <alltraps>

8010637b <vector147>:
.globl vector147
vector147:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $147
8010637d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106382:	e9 d7 f5 ff ff       	jmp    8010595e <alltraps>

80106387 <vector148>:
.globl vector148
vector148:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $148
80106389:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010638e:	e9 cb f5 ff ff       	jmp    8010595e <alltraps>

80106393 <vector149>:
.globl vector149
vector149:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $149
80106395:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010639a:	e9 bf f5 ff ff       	jmp    8010595e <alltraps>

8010639f <vector150>:
.globl vector150
vector150:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $150
801063a1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801063a6:	e9 b3 f5 ff ff       	jmp    8010595e <alltraps>

801063ab <vector151>:
.globl vector151
vector151:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $151
801063ad:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801063b2:	e9 a7 f5 ff ff       	jmp    8010595e <alltraps>

801063b7 <vector152>:
.globl vector152
vector152:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $152
801063b9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801063be:	e9 9b f5 ff ff       	jmp    8010595e <alltraps>

801063c3 <vector153>:
.globl vector153
vector153:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $153
801063c5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801063ca:	e9 8f f5 ff ff       	jmp    8010595e <alltraps>

801063cf <vector154>:
.globl vector154
vector154:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $154
801063d1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063d6:	e9 83 f5 ff ff       	jmp    8010595e <alltraps>

801063db <vector155>:
.globl vector155
vector155:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $155
801063dd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801063e2:	e9 77 f5 ff ff       	jmp    8010595e <alltraps>

801063e7 <vector156>:
.globl vector156
vector156:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $156
801063e9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801063ee:	e9 6b f5 ff ff       	jmp    8010595e <alltraps>

801063f3 <vector157>:
.globl vector157
vector157:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $157
801063f5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801063fa:	e9 5f f5 ff ff       	jmp    8010595e <alltraps>

801063ff <vector158>:
.globl vector158
vector158:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $158
80106401:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106406:	e9 53 f5 ff ff       	jmp    8010595e <alltraps>

8010640b <vector159>:
.globl vector159
vector159:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $159
8010640d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106412:	e9 47 f5 ff ff       	jmp    8010595e <alltraps>

80106417 <vector160>:
.globl vector160
vector160:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $160
80106419:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010641e:	e9 3b f5 ff ff       	jmp    8010595e <alltraps>

80106423 <vector161>:
.globl vector161
vector161:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $161
80106425:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010642a:	e9 2f f5 ff ff       	jmp    8010595e <alltraps>

8010642f <vector162>:
.globl vector162
vector162:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $162
80106431:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106436:	e9 23 f5 ff ff       	jmp    8010595e <alltraps>

8010643b <vector163>:
.globl vector163
vector163:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $163
8010643d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106442:	e9 17 f5 ff ff       	jmp    8010595e <alltraps>

80106447 <vector164>:
.globl vector164
vector164:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $164
80106449:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010644e:	e9 0b f5 ff ff       	jmp    8010595e <alltraps>

80106453 <vector165>:
.globl vector165
vector165:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $165
80106455:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010645a:	e9 ff f4 ff ff       	jmp    8010595e <alltraps>

8010645f <vector166>:
.globl vector166
vector166:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $166
80106461:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106466:	e9 f3 f4 ff ff       	jmp    8010595e <alltraps>

8010646b <vector167>:
.globl vector167
vector167:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $167
8010646d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106472:	e9 e7 f4 ff ff       	jmp    8010595e <alltraps>

80106477 <vector168>:
.globl vector168
vector168:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $168
80106479:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010647e:	e9 db f4 ff ff       	jmp    8010595e <alltraps>

80106483 <vector169>:
.globl vector169
vector169:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $169
80106485:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010648a:	e9 cf f4 ff ff       	jmp    8010595e <alltraps>

8010648f <vector170>:
.globl vector170
vector170:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $170
80106491:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106496:	e9 c3 f4 ff ff       	jmp    8010595e <alltraps>

8010649b <vector171>:
.globl vector171
vector171:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $171
8010649d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801064a2:	e9 b7 f4 ff ff       	jmp    8010595e <alltraps>

801064a7 <vector172>:
.globl vector172
vector172:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $172
801064a9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801064ae:	e9 ab f4 ff ff       	jmp    8010595e <alltraps>

801064b3 <vector173>:
.globl vector173
vector173:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $173
801064b5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801064ba:	e9 9f f4 ff ff       	jmp    8010595e <alltraps>

801064bf <vector174>:
.globl vector174
vector174:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $174
801064c1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801064c6:	e9 93 f4 ff ff       	jmp    8010595e <alltraps>

801064cb <vector175>:
.globl vector175
vector175:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $175
801064cd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064d2:	e9 87 f4 ff ff       	jmp    8010595e <alltraps>

801064d7 <vector176>:
.globl vector176
vector176:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $176
801064d9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064de:	e9 7b f4 ff ff       	jmp    8010595e <alltraps>

801064e3 <vector177>:
.globl vector177
vector177:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $177
801064e5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801064ea:	e9 6f f4 ff ff       	jmp    8010595e <alltraps>

801064ef <vector178>:
.globl vector178
vector178:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $178
801064f1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801064f6:	e9 63 f4 ff ff       	jmp    8010595e <alltraps>

801064fb <vector179>:
.globl vector179
vector179:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $179
801064fd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106502:	e9 57 f4 ff ff       	jmp    8010595e <alltraps>

80106507 <vector180>:
.globl vector180
vector180:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $180
80106509:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010650e:	e9 4b f4 ff ff       	jmp    8010595e <alltraps>

80106513 <vector181>:
.globl vector181
vector181:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $181
80106515:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010651a:	e9 3f f4 ff ff       	jmp    8010595e <alltraps>

8010651f <vector182>:
.globl vector182
vector182:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $182
80106521:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106526:	e9 33 f4 ff ff       	jmp    8010595e <alltraps>

8010652b <vector183>:
.globl vector183
vector183:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $183
8010652d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106532:	e9 27 f4 ff ff       	jmp    8010595e <alltraps>

80106537 <vector184>:
.globl vector184
vector184:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $184
80106539:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010653e:	e9 1b f4 ff ff       	jmp    8010595e <alltraps>

80106543 <vector185>:
.globl vector185
vector185:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $185
80106545:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010654a:	e9 0f f4 ff ff       	jmp    8010595e <alltraps>

8010654f <vector186>:
.globl vector186
vector186:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $186
80106551:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106556:	e9 03 f4 ff ff       	jmp    8010595e <alltraps>

8010655b <vector187>:
.globl vector187
vector187:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $187
8010655d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106562:	e9 f7 f3 ff ff       	jmp    8010595e <alltraps>

80106567 <vector188>:
.globl vector188
vector188:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $188
80106569:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010656e:	e9 eb f3 ff ff       	jmp    8010595e <alltraps>

80106573 <vector189>:
.globl vector189
vector189:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $189
80106575:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010657a:	e9 df f3 ff ff       	jmp    8010595e <alltraps>

8010657f <vector190>:
.globl vector190
vector190:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $190
80106581:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106586:	e9 d3 f3 ff ff       	jmp    8010595e <alltraps>

8010658b <vector191>:
.globl vector191
vector191:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $191
8010658d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106592:	e9 c7 f3 ff ff       	jmp    8010595e <alltraps>

80106597 <vector192>:
.globl vector192
vector192:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $192
80106599:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010659e:	e9 bb f3 ff ff       	jmp    8010595e <alltraps>

801065a3 <vector193>:
.globl vector193
vector193:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $193
801065a5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801065aa:	e9 af f3 ff ff       	jmp    8010595e <alltraps>

801065af <vector194>:
.globl vector194
vector194:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $194
801065b1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801065b6:	e9 a3 f3 ff ff       	jmp    8010595e <alltraps>

801065bb <vector195>:
.globl vector195
vector195:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $195
801065bd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801065c2:	e9 97 f3 ff ff       	jmp    8010595e <alltraps>

801065c7 <vector196>:
.globl vector196
vector196:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $196
801065c9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801065ce:	e9 8b f3 ff ff       	jmp    8010595e <alltraps>

801065d3 <vector197>:
.globl vector197
vector197:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $197
801065d5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065da:	e9 7f f3 ff ff       	jmp    8010595e <alltraps>

801065df <vector198>:
.globl vector198
vector198:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $198
801065e1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801065e6:	e9 73 f3 ff ff       	jmp    8010595e <alltraps>

801065eb <vector199>:
.globl vector199
vector199:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $199
801065ed:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801065f2:	e9 67 f3 ff ff       	jmp    8010595e <alltraps>

801065f7 <vector200>:
.globl vector200
vector200:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $200
801065f9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801065fe:	e9 5b f3 ff ff       	jmp    8010595e <alltraps>

80106603 <vector201>:
.globl vector201
vector201:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $201
80106605:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010660a:	e9 4f f3 ff ff       	jmp    8010595e <alltraps>

8010660f <vector202>:
.globl vector202
vector202:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $202
80106611:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106616:	e9 43 f3 ff ff       	jmp    8010595e <alltraps>

8010661b <vector203>:
.globl vector203
vector203:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $203
8010661d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106622:	e9 37 f3 ff ff       	jmp    8010595e <alltraps>

80106627 <vector204>:
.globl vector204
vector204:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $204
80106629:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010662e:	e9 2b f3 ff ff       	jmp    8010595e <alltraps>

80106633 <vector205>:
.globl vector205
vector205:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $205
80106635:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010663a:	e9 1f f3 ff ff       	jmp    8010595e <alltraps>

8010663f <vector206>:
.globl vector206
vector206:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $206
80106641:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106646:	e9 13 f3 ff ff       	jmp    8010595e <alltraps>

8010664b <vector207>:
.globl vector207
vector207:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $207
8010664d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106652:	e9 07 f3 ff ff       	jmp    8010595e <alltraps>

80106657 <vector208>:
.globl vector208
vector208:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $208
80106659:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010665e:	e9 fb f2 ff ff       	jmp    8010595e <alltraps>

80106663 <vector209>:
.globl vector209
vector209:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $209
80106665:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010666a:	e9 ef f2 ff ff       	jmp    8010595e <alltraps>

8010666f <vector210>:
.globl vector210
vector210:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $210
80106671:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106676:	e9 e3 f2 ff ff       	jmp    8010595e <alltraps>

8010667b <vector211>:
.globl vector211
vector211:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $211
8010667d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106682:	e9 d7 f2 ff ff       	jmp    8010595e <alltraps>

80106687 <vector212>:
.globl vector212
vector212:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $212
80106689:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010668e:	e9 cb f2 ff ff       	jmp    8010595e <alltraps>

80106693 <vector213>:
.globl vector213
vector213:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $213
80106695:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010669a:	e9 bf f2 ff ff       	jmp    8010595e <alltraps>

8010669f <vector214>:
.globl vector214
vector214:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $214
801066a1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801066a6:	e9 b3 f2 ff ff       	jmp    8010595e <alltraps>

801066ab <vector215>:
.globl vector215
vector215:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $215
801066ad:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801066b2:	e9 a7 f2 ff ff       	jmp    8010595e <alltraps>

801066b7 <vector216>:
.globl vector216
vector216:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $216
801066b9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801066be:	e9 9b f2 ff ff       	jmp    8010595e <alltraps>

801066c3 <vector217>:
.globl vector217
vector217:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $217
801066c5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801066ca:	e9 8f f2 ff ff       	jmp    8010595e <alltraps>

801066cf <vector218>:
.globl vector218
vector218:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $218
801066d1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066d6:	e9 83 f2 ff ff       	jmp    8010595e <alltraps>

801066db <vector219>:
.globl vector219
vector219:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $219
801066dd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801066e2:	e9 77 f2 ff ff       	jmp    8010595e <alltraps>

801066e7 <vector220>:
.globl vector220
vector220:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $220
801066e9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801066ee:	e9 6b f2 ff ff       	jmp    8010595e <alltraps>

801066f3 <vector221>:
.globl vector221
vector221:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $221
801066f5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801066fa:	e9 5f f2 ff ff       	jmp    8010595e <alltraps>

801066ff <vector222>:
.globl vector222
vector222:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $222
80106701:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106706:	e9 53 f2 ff ff       	jmp    8010595e <alltraps>

8010670b <vector223>:
.globl vector223
vector223:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $223
8010670d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106712:	e9 47 f2 ff ff       	jmp    8010595e <alltraps>

80106717 <vector224>:
.globl vector224
vector224:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $224
80106719:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010671e:	e9 3b f2 ff ff       	jmp    8010595e <alltraps>

80106723 <vector225>:
.globl vector225
vector225:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $225
80106725:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010672a:	e9 2f f2 ff ff       	jmp    8010595e <alltraps>

8010672f <vector226>:
.globl vector226
vector226:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $226
80106731:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106736:	e9 23 f2 ff ff       	jmp    8010595e <alltraps>

8010673b <vector227>:
.globl vector227
vector227:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $227
8010673d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106742:	e9 17 f2 ff ff       	jmp    8010595e <alltraps>

80106747 <vector228>:
.globl vector228
vector228:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $228
80106749:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010674e:	e9 0b f2 ff ff       	jmp    8010595e <alltraps>

80106753 <vector229>:
.globl vector229
vector229:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $229
80106755:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010675a:	e9 ff f1 ff ff       	jmp    8010595e <alltraps>

8010675f <vector230>:
.globl vector230
vector230:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $230
80106761:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106766:	e9 f3 f1 ff ff       	jmp    8010595e <alltraps>

8010676b <vector231>:
.globl vector231
vector231:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $231
8010676d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106772:	e9 e7 f1 ff ff       	jmp    8010595e <alltraps>

80106777 <vector232>:
.globl vector232
vector232:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $232
80106779:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010677e:	e9 db f1 ff ff       	jmp    8010595e <alltraps>

80106783 <vector233>:
.globl vector233
vector233:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $233
80106785:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010678a:	e9 cf f1 ff ff       	jmp    8010595e <alltraps>

8010678f <vector234>:
.globl vector234
vector234:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $234
80106791:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106796:	e9 c3 f1 ff ff       	jmp    8010595e <alltraps>

8010679b <vector235>:
.globl vector235
vector235:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $235
8010679d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801067a2:	e9 b7 f1 ff ff       	jmp    8010595e <alltraps>

801067a7 <vector236>:
.globl vector236
vector236:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $236
801067a9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801067ae:	e9 ab f1 ff ff       	jmp    8010595e <alltraps>

801067b3 <vector237>:
.globl vector237
vector237:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $237
801067b5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801067ba:	e9 9f f1 ff ff       	jmp    8010595e <alltraps>

801067bf <vector238>:
.globl vector238
vector238:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $238
801067c1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801067c6:	e9 93 f1 ff ff       	jmp    8010595e <alltraps>

801067cb <vector239>:
.globl vector239
vector239:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $239
801067cd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067d2:	e9 87 f1 ff ff       	jmp    8010595e <alltraps>

801067d7 <vector240>:
.globl vector240
vector240:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $240
801067d9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067de:	e9 7b f1 ff ff       	jmp    8010595e <alltraps>

801067e3 <vector241>:
.globl vector241
vector241:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $241
801067e5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801067ea:	e9 6f f1 ff ff       	jmp    8010595e <alltraps>

801067ef <vector242>:
.globl vector242
vector242:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $242
801067f1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801067f6:	e9 63 f1 ff ff       	jmp    8010595e <alltraps>

801067fb <vector243>:
.globl vector243
vector243:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $243
801067fd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106802:	e9 57 f1 ff ff       	jmp    8010595e <alltraps>

80106807 <vector244>:
.globl vector244
vector244:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $244
80106809:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010680e:	e9 4b f1 ff ff       	jmp    8010595e <alltraps>

80106813 <vector245>:
.globl vector245
vector245:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $245
80106815:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010681a:	e9 3f f1 ff ff       	jmp    8010595e <alltraps>

8010681f <vector246>:
.globl vector246
vector246:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $246
80106821:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106826:	e9 33 f1 ff ff       	jmp    8010595e <alltraps>

8010682b <vector247>:
.globl vector247
vector247:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $247
8010682d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106832:	e9 27 f1 ff ff       	jmp    8010595e <alltraps>

80106837 <vector248>:
.globl vector248
vector248:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $248
80106839:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010683e:	e9 1b f1 ff ff       	jmp    8010595e <alltraps>

80106843 <vector249>:
.globl vector249
vector249:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $249
80106845:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010684a:	e9 0f f1 ff ff       	jmp    8010595e <alltraps>

8010684f <vector250>:
.globl vector250
vector250:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $250
80106851:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106856:	e9 03 f1 ff ff       	jmp    8010595e <alltraps>

8010685b <vector251>:
.globl vector251
vector251:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $251
8010685d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106862:	e9 f7 f0 ff ff       	jmp    8010595e <alltraps>

80106867 <vector252>:
.globl vector252
vector252:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $252
80106869:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010686e:	e9 eb f0 ff ff       	jmp    8010595e <alltraps>

80106873 <vector253>:
.globl vector253
vector253:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $253
80106875:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010687a:	e9 df f0 ff ff       	jmp    8010595e <alltraps>

8010687f <vector254>:
.globl vector254
vector254:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $254
80106881:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106886:	e9 d3 f0 ff ff       	jmp    8010595e <alltraps>

8010688b <vector255>:
.globl vector255
vector255:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $255
8010688d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106892:	e9 c7 f0 ff ff       	jmp    8010595e <alltraps>
80106897:	66 90                	xchg   %ax,%ax
80106899:	66 90                	xchg   %ax,%ax
8010689b:	66 90                	xchg   %ax,%ax
8010689d:	66 90                	xchg   %ax,%ax
8010689f:	90                   	nop

801068a0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068a0:	55                   	push   %ebp
801068a1:	89 e5                	mov    %esp,%ebp
801068a3:	57                   	push   %edi
801068a4:	56                   	push   %esi
801068a5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801068a6:	89 d3                	mov    %edx,%ebx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068a8:	89 d7                	mov    %edx,%edi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801068aa:	c1 eb 16             	shr    $0x16,%ebx
801068ad:	8d 34 98             	lea    (%eax,%ebx,4),%esi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801068b0:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801068b3:	8b 06                	mov    (%esi),%eax
801068b5:	a8 01                	test   $0x1,%al
801068b7:	74 27                	je     801068e0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801068b9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801068be:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068c4:	c1 ef 0a             	shr    $0xa,%edi
}
801068c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801068ca:	89 fa                	mov    %edi,%edx
801068cc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801068d2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801068d5:	5b                   	pop    %ebx
801068d6:	5e                   	pop    %esi
801068d7:	5f                   	pop    %edi
801068d8:	5d                   	pop    %ebp
801068d9:	c3                   	ret    
801068da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801068e0:	85 c9                	test   %ecx,%ecx
801068e2:	74 2c                	je     80106910 <walkpgdir+0x70>
801068e4:	e8 a7 bb ff ff       	call   80102490 <kalloc>
801068e9:	85 c0                	test   %eax,%eax
801068eb:	89 c3                	mov    %eax,%ebx
801068ed:	74 21                	je     80106910 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801068ef:	83 ec 04             	sub    $0x4,%esp
801068f2:	68 00 10 00 00       	push   $0x1000
801068f7:	6a 00                	push   $0x0
801068f9:	50                   	push   %eax
801068fa:	e8 41 dd ff ff       	call   80104640 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801068ff:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106905:	83 c4 10             	add    $0x10,%esp
80106908:	83 c8 07             	or     $0x7,%eax
8010690b:	89 06                	mov    %eax,(%esi)
8010690d:	eb b5                	jmp    801068c4 <walkpgdir+0x24>
8010690f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106910:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106913:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106915:	5b                   	pop    %ebx
80106916:	5e                   	pop    %esi
80106917:	5f                   	pop    %edi
80106918:	5d                   	pop    %ebp
80106919:	c3                   	ret    
8010691a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106920 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106920:	55                   	push   %ebp
80106921:	89 e5                	mov    %esp,%ebp
80106923:	57                   	push   %edi
80106924:	56                   	push   %esi
80106925:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106926:	89 d3                	mov    %edx,%ebx
80106928:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010692e:	83 ec 1c             	sub    $0x1c,%esp
80106931:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106934:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106938:	8b 7d 08             	mov    0x8(%ebp),%edi
8010693b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106940:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106943:	8b 45 0c             	mov    0xc(%ebp),%eax
80106946:	29 df                	sub    %ebx,%edi
80106948:	83 c8 01             	or     $0x1,%eax
8010694b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010694e:	eb 15                	jmp    80106965 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106950:	f6 00 01             	testb  $0x1,(%eax)
80106953:	75 45                	jne    8010699a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106955:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106958:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010695b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010695d:	74 31                	je     80106990 <mappages+0x70>
      break;
    a += PGSIZE;
8010695f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106965:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106968:	b9 01 00 00 00       	mov    $0x1,%ecx
8010696d:	89 da                	mov    %ebx,%edx
8010696f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106972:	e8 29 ff ff ff       	call   801068a0 <walkpgdir>
80106977:	85 c0                	test   %eax,%eax
80106979:	75 d5                	jne    80106950 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010697b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010697e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106983:	5b                   	pop    %ebx
80106984:	5e                   	pop    %esi
80106985:	5f                   	pop    %edi
80106986:	5d                   	pop    %ebp
80106987:	c3                   	ret    
80106988:	90                   	nop
80106989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106990:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106993:	31 c0                	xor    %eax,%eax
}
80106995:	5b                   	pop    %ebx
80106996:	5e                   	pop    %esi
80106997:	5f                   	pop    %edi
80106998:	5d                   	pop    %ebp
80106999:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010699a:	83 ec 0c             	sub    $0xc,%esp
8010699d:	68 10 7b 10 80       	push   $0x80107b10
801069a2:	e8 c9 99 ff ff       	call   80100370 <panic>
801069a7:	89 f6                	mov    %esi,%esi
801069a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069b0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	57                   	push   %edi
801069b4:	56                   	push   %esi
801069b5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801069b6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069bc:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801069be:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801069c4:	83 ec 1c             	sub    $0x1c,%esp
801069c7:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069ca:	39 d3                	cmp    %edx,%ebx
801069cc:	73 66                	jae    80106a34 <deallocuvm.part.0+0x84>
801069ce:	89 d6                	mov    %edx,%esi
801069d0:	eb 3d                	jmp    80106a0f <deallocuvm.part.0+0x5f>
801069d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801069d8:	8b 10                	mov    (%eax),%edx
801069da:	f6 c2 01             	test   $0x1,%dl
801069dd:	74 26                	je     80106a05 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801069df:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801069e5:	74 58                	je     80106a3f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801069e7:	83 ec 0c             	sub    $0xc,%esp
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
      char *v = P2V(pa);
801069ea:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801069f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
801069f3:	52                   	push   %edx
801069f4:	e8 e7 b8 ff ff       	call   801022e0 <kfree>
      *pte = 0;
801069f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069fc:	83 c4 10             	add    $0x10,%esp
801069ff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a05:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a0b:	39 f3                	cmp    %esi,%ebx
80106a0d:	73 25                	jae    80106a34 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a0f:	31 c9                	xor    %ecx,%ecx
80106a11:	89 da                	mov    %ebx,%edx
80106a13:	89 f8                	mov    %edi,%eax
80106a15:	e8 86 fe ff ff       	call   801068a0 <walkpgdir>
    if(!pte)
80106a1a:	85 c0                	test   %eax,%eax
80106a1c:	75 ba                	jne    801069d8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a1e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a24:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a2a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a30:	39 f3                	cmp    %esi,%ebx
80106a32:	72 db                	jb     80106a0f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a34:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106a37:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a3a:	5b                   	pop    %ebx
80106a3b:	5e                   	pop    %esi
80106a3c:	5f                   	pop    %edi
80106a3d:	5d                   	pop    %ebp
80106a3e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a3f:	83 ec 0c             	sub    $0xc,%esp
80106a42:	68 66 74 10 80       	push   $0x80107466
80106a47:	e8 24 99 ff ff       	call   80100370 <panic>
80106a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a50 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
80106a53:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106a56:	e8 55 ce ff ff       	call   801038b0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a5b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a61:	31 c9                	xor    %ecx,%ecx
80106a63:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a68:	66 89 90 f8 27 11 80 	mov    %dx,-0x7feed808(%eax)
80106a6f:	66 89 88 fa 27 11 80 	mov    %cx,-0x7feed806(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a76:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106a7b:	31 c9                	xor    %ecx,%ecx
80106a7d:	66 89 90 00 28 11 80 	mov    %dx,-0x7feed800(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a84:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a89:	66 89 88 02 28 11 80 	mov    %cx,-0x7feed7fe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a90:	31 c9                	xor    %ecx,%ecx
80106a92:	66 89 90 08 28 11 80 	mov    %dx,-0x7feed7f8(%eax)
80106a99:	66 89 88 0a 28 11 80 	mov    %cx,-0x7feed7f6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106aa0:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106aa5:	31 c9                	xor    %ecx,%ecx
80106aa7:	66 89 90 10 28 11 80 	mov    %dx,-0x7feed7f0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106aae:	c6 80 fc 27 11 80 00 	movb   $0x0,-0x7feed804(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106ab5:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106aba:	c6 80 fd 27 11 80 9a 	movb   $0x9a,-0x7feed803(%eax)
80106ac1:	c6 80 fe 27 11 80 cf 	movb   $0xcf,-0x7feed802(%eax)
80106ac8:	c6 80 ff 27 11 80 00 	movb   $0x0,-0x7feed801(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106acf:	c6 80 04 28 11 80 00 	movb   $0x0,-0x7feed7fc(%eax)
80106ad6:	c6 80 05 28 11 80 92 	movb   $0x92,-0x7feed7fb(%eax)
80106add:	c6 80 06 28 11 80 cf 	movb   $0xcf,-0x7feed7fa(%eax)
80106ae4:	c6 80 07 28 11 80 00 	movb   $0x0,-0x7feed7f9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106aeb:	c6 80 0c 28 11 80 00 	movb   $0x0,-0x7feed7f4(%eax)
80106af2:	c6 80 0d 28 11 80 fa 	movb   $0xfa,-0x7feed7f3(%eax)
80106af9:	c6 80 0e 28 11 80 cf 	movb   $0xcf,-0x7feed7f2(%eax)
80106b00:	c6 80 0f 28 11 80 00 	movb   $0x0,-0x7feed7f1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b07:	66 89 88 12 28 11 80 	mov    %cx,-0x7feed7ee(%eax)
80106b0e:	c6 80 14 28 11 80 00 	movb   $0x0,-0x7feed7ec(%eax)
80106b15:	c6 80 15 28 11 80 f2 	movb   $0xf2,-0x7feed7eb(%eax)
80106b1c:	c6 80 16 28 11 80 cf 	movb   $0xcf,-0x7feed7ea(%eax)
80106b23:	c6 80 17 28 11 80 00 	movb   $0x0,-0x7feed7e9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106b2a:	05 f0 27 11 80       	add    $0x801127f0,%eax
80106b2f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106b33:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b37:	c1 e8 10             	shr    $0x10,%eax
80106b3a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106b3e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b41:	0f 01 10             	lgdtl  (%eax)
}
80106b44:	c9                   	leave  
80106b45:	c3                   	ret    
80106b46:	8d 76 00             	lea    0x0(%esi),%esi
80106b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b50 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b50:	a1 a4 5c 11 80       	mov    0x80115ca4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106b55:	55                   	push   %ebp
80106b56:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b58:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b5d:	0f 22 d8             	mov    %eax,%cr3
}
80106b60:	5d                   	pop    %ebp
80106b61:	c3                   	ret    
80106b62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b70 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	57                   	push   %edi
80106b74:	56                   	push   %esi
80106b75:	53                   	push   %ebx
80106b76:	83 ec 1c             	sub    $0x1c,%esp
80106b79:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106b7c:	85 f6                	test   %esi,%esi
80106b7e:	0f 84 cd 00 00 00    	je     80106c51 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106b84:	8b 46 08             	mov    0x8(%esi),%eax
80106b87:	85 c0                	test   %eax,%eax
80106b89:	0f 84 dc 00 00 00    	je     80106c6b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106b8f:	8b 7e 04             	mov    0x4(%esi),%edi
80106b92:	85 ff                	test   %edi,%edi
80106b94:	0f 84 c4 00 00 00    	je     80106c5e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106b9a:	e8 f1 d8 ff ff       	call   80104490 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts, sizeof(mycpu()->ts)-1, 0);
80106b9f:	e8 8c cc ff ff       	call   80103830 <mycpu>
80106ba4:	89 c3                	mov    %eax,%ebx
80106ba6:	e8 85 cc ff ff       	call   80103830 <mycpu>
80106bab:	89 c7                	mov    %eax,%edi
80106bad:	e8 7e cc ff ff       	call   80103830 <mycpu>
80106bb2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106bb5:	83 c7 08             	add    $0x8,%edi
80106bb8:	e8 73 cc ff ff       	call   80103830 <mycpu>
80106bbd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106bc0:	83 c0 08             	add    $0x8,%eax
80106bc3:	ba 67 00 00 00       	mov    $0x67,%edx
80106bc8:	c1 e8 18             	shr    $0x18,%eax
80106bcb:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106bd2:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106bd9:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106be0:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106be7:	83 c1 08             	add    $0x8,%ecx
80106bea:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106bf0:	c1 e9 10             	shr    $0x10,%ecx
80106bf3:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106bf9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts, sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106bfe:	e8 2d cc ff ff       	call   80103830 <mycpu>
80106c03:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c0a:	e8 21 cc ff ff       	call   80103830 <mycpu>
80106c0f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106c14:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c18:	e8 13 cc ff ff       	call   80103830 <mycpu>
80106c1d:	8b 56 08             	mov    0x8(%esi),%edx
80106c20:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106c26:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c29:	e8 02 cc ff ff       	call   80103830 <mycpu>
80106c2e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106c32:	b8 28 00 00 00       	mov    $0x28,%eax
80106c37:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106c3a:	8b 46 04             	mov    0x4(%esi),%eax
80106c3d:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c42:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80106c45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c48:	5b                   	pop    %ebx
80106c49:	5e                   	pop    %esi
80106c4a:	5f                   	pop    %edi
80106c4b:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106c4c:	e9 2f d9 ff ff       	jmp    80104580 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106c51:	83 ec 0c             	sub    $0xc,%esp
80106c54:	68 16 7b 10 80       	push   $0x80107b16
80106c59:	e8 12 97 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106c5e:	83 ec 0c             	sub    $0xc,%esp
80106c61:	68 41 7b 10 80       	push   $0x80107b41
80106c66:	e8 05 97 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106c6b:	83 ec 0c             	sub    $0xc,%esp
80106c6e:	68 2c 7b 10 80       	push   $0x80107b2c
80106c73:	e8 f8 96 ff ff       	call   80100370 <panic>
80106c78:	90                   	nop
80106c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c80 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	57                   	push   %edi
80106c84:	56                   	push   %esi
80106c85:	53                   	push   %ebx
80106c86:	83 ec 1c             	sub    $0x1c,%esp
80106c89:	8b 75 10             	mov    0x10(%ebp),%esi
80106c8c:	8b 45 08             	mov    0x8(%ebp),%eax
80106c8f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106c92:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106c98:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106c9b:	77 49                	ja     80106ce6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106c9d:	e8 ee b7 ff ff       	call   80102490 <kalloc>
  memset(mem, 0, PGSIZE);
80106ca2:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106ca5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106ca7:	68 00 10 00 00       	push   $0x1000
80106cac:	6a 00                	push   $0x0
80106cae:	50                   	push   %eax
80106caf:	e8 8c d9 ff ff       	call   80104640 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106cb4:	58                   	pop    %eax
80106cb5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106cbb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106cc0:	5a                   	pop    %edx
80106cc1:	6a 06                	push   $0x6
80106cc3:	50                   	push   %eax
80106cc4:	31 d2                	xor    %edx,%edx
80106cc6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106cc9:	e8 52 fc ff ff       	call   80106920 <mappages>
  memmove(mem, init, sz);
80106cce:	89 75 10             	mov    %esi,0x10(%ebp)
80106cd1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106cd4:	83 c4 10             	add    $0x10,%esp
80106cd7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106cda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cdd:	5b                   	pop    %ebx
80106cde:	5e                   	pop    %esi
80106cdf:	5f                   	pop    %edi
80106ce0:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106ce1:	e9 0a da ff ff       	jmp    801046f0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106ce6:	83 ec 0c             	sub    $0xc,%esp
80106ce9:	68 55 7b 10 80       	push   $0x80107b55
80106cee:	e8 7d 96 ff ff       	call   80100370 <panic>
80106cf3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	57                   	push   %edi
80106d04:	56                   	push   %esi
80106d05:	53                   	push   %ebx
80106d06:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106d09:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106d10:	0f 85 91 00 00 00    	jne    80106da7 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106d16:	8b 75 18             	mov    0x18(%ebp),%esi
80106d19:	31 db                	xor    %ebx,%ebx
80106d1b:	85 f6                	test   %esi,%esi
80106d1d:	75 1a                	jne    80106d39 <loaduvm+0x39>
80106d1f:	eb 6f                	jmp    80106d90 <loaduvm+0x90>
80106d21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d28:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d2e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106d34:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106d37:	76 57                	jbe    80106d90 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d39:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d3c:	8b 45 08             	mov    0x8(%ebp),%eax
80106d3f:	31 c9                	xor    %ecx,%ecx
80106d41:	01 da                	add    %ebx,%edx
80106d43:	e8 58 fb ff ff       	call   801068a0 <walkpgdir>
80106d48:	85 c0                	test   %eax,%eax
80106d4a:	74 4e                	je     80106d9a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d4c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d4e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106d51:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106d56:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106d5b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d61:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d64:	01 d9                	add    %ebx,%ecx
80106d66:	05 00 00 00 80       	add    $0x80000000,%eax
80106d6b:	57                   	push   %edi
80106d6c:	51                   	push   %ecx
80106d6d:	50                   	push   %eax
80106d6e:	ff 75 10             	pushl  0x10(%ebp)
80106d71:	e8 ba ab ff ff       	call   80101930 <readi>
80106d76:	83 c4 10             	add    $0x10,%esp
80106d79:	39 c7                	cmp    %eax,%edi
80106d7b:	74 ab                	je     80106d28 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106d7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106d85:	5b                   	pop    %ebx
80106d86:	5e                   	pop    %esi
80106d87:	5f                   	pop    %edi
80106d88:	5d                   	pop    %ebp
80106d89:	c3                   	ret    
80106d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d90:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106d93:	31 c0                	xor    %eax,%eax
}
80106d95:	5b                   	pop    %ebx
80106d96:	5e                   	pop    %esi
80106d97:	5f                   	pop    %edi
80106d98:	5d                   	pop    %ebp
80106d99:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106d9a:	83 ec 0c             	sub    $0xc,%esp
80106d9d:	68 6f 7b 10 80       	push   $0x80107b6f
80106da2:	e8 c9 95 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106da7:	83 ec 0c             	sub    $0xc,%esp
80106daa:	68 10 7c 10 80       	push   $0x80107c10
80106daf:	e8 bc 95 ff ff       	call   80100370 <panic>
80106db4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106dba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106dc0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106dc0:	55                   	push   %ebp
80106dc1:	89 e5                	mov    %esp,%ebp
80106dc3:	57                   	push   %edi
80106dc4:	56                   	push   %esi
80106dc5:	53                   	push   %ebx
80106dc6:	83 ec 0c             	sub    $0xc,%esp
80106dc9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106dcc:	85 ff                	test   %edi,%edi
80106dce:	78 7b                	js     80106e4b <allocuvm+0x8b>
    return 0;
  if(newsz < oldsz)
80106dd0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106dd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106dd6:	72 75                	jb     80106e4d <allocuvm+0x8d>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106dd8:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106dde:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106de4:	39 df                	cmp    %ebx,%edi
80106de6:	77 43                	ja     80106e2b <allocuvm+0x6b>
80106de8:	eb 6e                	jmp    80106e58 <allocuvm+0x98>
80106dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106df0:	83 ec 04             	sub    $0x4,%esp
80106df3:	68 00 10 00 00       	push   $0x1000
80106df8:	6a 00                	push   $0x0
80106dfa:	50                   	push   %eax
80106dfb:	e8 40 d8 ff ff       	call   80104640 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e00:	58                   	pop    %eax
80106e01:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106e07:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e0c:	5a                   	pop    %edx
80106e0d:	6a 06                	push   $0x6
80106e0f:	50                   	push   %eax
80106e10:	89 da                	mov    %ebx,%edx
80106e12:	8b 45 08             	mov    0x8(%ebp),%eax
80106e15:	e8 06 fb ff ff       	call   80106920 <mappages>
80106e1a:	83 c4 10             	add    $0x10,%esp
80106e1d:	85 c0                	test   %eax,%eax
80106e1f:	78 47                	js     80106e68 <allocuvm+0xa8>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e21:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e27:	39 df                	cmp    %ebx,%edi
80106e29:	76 2d                	jbe    80106e58 <allocuvm+0x98>
    mem = kalloc();
80106e2b:	e8 60 b6 ff ff       	call   80102490 <kalloc>
    if(mem == 0){
80106e30:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106e32:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106e34:	75 ba                	jne    80106df0 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
80106e36:	83 ec 0c             	sub    $0xc,%esp
80106e39:	68 8d 7b 10 80       	push   $0x80107b8d
80106e3e:	e8 1d 98 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e43:	83 c4 10             	add    $0x10,%esp
80106e46:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e49:	77 4f                	ja     80106e9a <allocuvm+0xda>
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106e4b:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e50:	5b                   	pop    %ebx
80106e51:	5e                   	pop    %esi
80106e52:	5f                   	pop    %edi
80106e53:	5d                   	pop    %ebp
80106e54:	c3                   	ret    
80106e55:	8d 76 00             	lea    0x0(%esi),%esi
80106e58:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106e5b:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106e5d:	5b                   	pop    %ebx
80106e5e:	5e                   	pop    %esi
80106e5f:	5f                   	pop    %edi
80106e60:	5d                   	pop    %ebp
80106e61:	c3                   	ret    
80106e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106e68:	83 ec 0c             	sub    $0xc,%esp
80106e6b:	68 a5 7b 10 80       	push   $0x80107ba5
80106e70:	e8 eb 97 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106e75:	83 c4 10             	add    $0x10,%esp
80106e78:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106e7b:	76 0d                	jbe    80106e8a <allocuvm+0xca>
80106e7d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e80:	8b 45 08             	mov    0x8(%ebp),%eax
80106e83:	89 fa                	mov    %edi,%edx
80106e85:	e8 26 fb ff ff       	call   801069b0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106e8a:	83 ec 0c             	sub    $0xc,%esp
80106e8d:	56                   	push   %esi
80106e8e:	e8 4d b4 ff ff       	call   801022e0 <kfree>
      return 0;
80106e93:	83 c4 10             	add    $0x10,%esp
80106e96:	31 c0                	xor    %eax,%eax
80106e98:	eb b3                	jmp    80106e4d <allocuvm+0x8d>
80106e9a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e9d:	8b 45 08             	mov    0x8(%ebp),%eax
80106ea0:	89 fa                	mov    %edi,%edx
80106ea2:	e8 09 fb ff ff       	call   801069b0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106ea7:	31 c0                	xor    %eax,%eax
80106ea9:	eb a2                	jmp    80106e4d <allocuvm+0x8d>
80106eab:	90                   	nop
80106eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106eb0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106eb6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106ebc:	39 d1                	cmp    %edx,%ecx
80106ebe:	73 10                	jae    80106ed0 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106ec0:	5d                   	pop    %ebp
80106ec1:	e9 ea fa ff ff       	jmp    801069b0 <deallocuvm.part.0>
80106ec6:	8d 76 00             	lea    0x0(%esi),%esi
80106ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106ed0:	89 d0                	mov    %edx,%eax
80106ed2:	5d                   	pop    %ebp
80106ed3:	c3                   	ret    
80106ed4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106eda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ee0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	57                   	push   %edi
80106ee4:	56                   	push   %esi
80106ee5:	53                   	push   %ebx
80106ee6:	83 ec 0c             	sub    $0xc,%esp
80106ee9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106eec:	85 f6                	test   %esi,%esi
80106eee:	74 59                	je     80106f49 <freevm+0x69>
80106ef0:	31 c9                	xor    %ecx,%ecx
80106ef2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106ef7:	89 f0                	mov    %esi,%eax
80106ef9:	e8 b2 fa ff ff       	call   801069b0 <deallocuvm.part.0>
80106efe:	89 f3                	mov    %esi,%ebx
80106f00:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f06:	eb 0f                	jmp    80106f17 <freevm+0x37>
80106f08:	90                   	nop
80106f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f10:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f13:	39 fb                	cmp    %edi,%ebx
80106f15:	74 23                	je     80106f3a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f17:	8b 03                	mov    (%ebx),%eax
80106f19:	a8 01                	test   $0x1,%al
80106f1b:	74 f3                	je     80106f10 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f1d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106f22:	83 ec 0c             	sub    $0xc,%esp
80106f25:	83 c3 04             	add    $0x4,%ebx
  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f28:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106f2d:	50                   	push   %eax
80106f2e:	e8 ad b3 ff ff       	call   801022e0 <kfree>
80106f33:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f36:	39 fb                	cmp    %edi,%ebx
80106f38:	75 dd                	jne    80106f17 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f3a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f40:	5b                   	pop    %ebx
80106f41:	5e                   	pop    %esi
80106f42:	5f                   	pop    %edi
80106f43:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106f44:	e9 97 b3 ff ff       	jmp    801022e0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106f49:	83 ec 0c             	sub    $0xc,%esp
80106f4c:	68 c1 7b 10 80       	push   $0x80107bc1
80106f51:	e8 1a 94 ff ff       	call   80100370 <panic>
80106f56:	8d 76 00             	lea    0x0(%esi),%esi
80106f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f60 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	56                   	push   %esi
80106f64:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106f65:	e8 26 b5 ff ff       	call   80102490 <kalloc>
80106f6a:	85 c0                	test   %eax,%eax
80106f6c:	89 c6                	mov    %eax,%esi
80106f6e:	74 42                	je     80106fb2 <setupkvm+0x52>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f70:	83 ec 04             	sub    $0x4,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f73:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106f78:	68 00 10 00 00       	push   $0x1000
80106f7d:	6a 00                	push   $0x0
80106f7f:	50                   	push   %eax
80106f80:	e8 bb d6 ff ff       	call   80104640 <memset>
80106f85:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
80106f88:	8b 43 04             	mov    0x4(%ebx),%eax
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f8b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f8e:	83 ec 08             	sub    $0x8,%esp
80106f91:	8b 13                	mov    (%ebx),%edx
80106f93:	ff 73 0c             	pushl  0xc(%ebx)
80106f96:	50                   	push   %eax
80106f97:	29 c1                	sub    %eax,%ecx
80106f99:	89 f0                	mov    %esi,%eax
80106f9b:	e8 80 f9 ff ff       	call   80106920 <mappages>
80106fa0:	83 c4 10             	add    $0x10,%esp
80106fa3:	85 c0                	test   %eax,%eax
80106fa5:	78 19                	js     80106fc0 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106fa7:	83 c3 10             	add    $0x10,%ebx
80106faa:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106fb0:	72 d6                	jb     80106f88 <setupkvm+0x28>
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106fb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106fb5:	89 f0                	mov    %esi,%eax
80106fb7:	5b                   	pop    %ebx
80106fb8:	5e                   	pop    %esi
80106fb9:	5d                   	pop    %ebp
80106fba:	c3                   	ret    
80106fbb:	90                   	nop
80106fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106fc0:	83 ec 0c             	sub    $0xc,%esp
80106fc3:	56                   	push   %esi
      return 0;
80106fc4:	31 f6                	xor    %esi,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106fc6:	e8 15 ff ff ff       	call   80106ee0 <freevm>
      return 0;
80106fcb:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80106fce:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106fd1:	89 f0                	mov    %esi,%eax
80106fd3:	5b                   	pop    %ebx
80106fd4:	5e                   	pop    %esi
80106fd5:	5d                   	pop    %ebp
80106fd6:	c3                   	ret    
80106fd7:	89 f6                	mov    %esi,%esi
80106fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106fe0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106fe6:	e8 75 ff ff ff       	call   80106f60 <setupkvm>
80106feb:	a3 a4 5c 11 80       	mov    %eax,0x80115ca4
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ff0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ff5:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
80106ff8:	c9                   	leave  
80106ff9:	c3                   	ret    
80106ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107000 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107000:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107001:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107003:	89 e5                	mov    %esp,%ebp
80107005:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107008:	8b 55 0c             	mov    0xc(%ebp),%edx
8010700b:	8b 45 08             	mov    0x8(%ebp),%eax
8010700e:	e8 8d f8 ff ff       	call   801068a0 <walkpgdir>
  if(pte == 0)
80107013:	85 c0                	test   %eax,%eax
80107015:	74 05                	je     8010701c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107017:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010701a:	c9                   	leave  
8010701b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010701c:	83 ec 0c             	sub    $0xc,%esp
8010701f:	68 d2 7b 10 80       	push   $0x80107bd2
80107024:	e8 47 93 ff ff       	call   80100370 <panic>
80107029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107030 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	57                   	push   %edi
80107034:	56                   	push   %esi
80107035:	53                   	push   %ebx
80107036:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107039:	e8 22 ff ff ff       	call   80106f60 <setupkvm>
8010703e:	85 c0                	test   %eax,%eax
80107040:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107043:	0f 84 a0 00 00 00    	je     801070e9 <copyuvm+0xb9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107049:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010704c:	85 c9                	test   %ecx,%ecx
8010704e:	0f 84 95 00 00 00    	je     801070e9 <copyuvm+0xb9>
80107054:	31 f6                	xor    %esi,%esi
80107056:	eb 4e                	jmp    801070a6 <copyuvm+0x76>
80107058:	90                   	nop
80107059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107060:	83 ec 04             	sub    $0x4,%esp
80107063:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107069:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010706c:	68 00 10 00 00       	push   $0x1000
80107071:	57                   	push   %edi
80107072:	50                   	push   %eax
80107073:	e8 78 d6 ff ff       	call   801046f0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107078:	58                   	pop    %eax
80107079:	5a                   	pop    %edx
8010707a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010707d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107080:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107085:	53                   	push   %ebx
80107086:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010708c:	52                   	push   %edx
8010708d:	89 f2                	mov    %esi,%edx
8010708f:	e8 8c f8 ff ff       	call   80106920 <mappages>
80107094:	83 c4 10             	add    $0x10,%esp
80107097:	85 c0                	test   %eax,%eax
80107099:	78 39                	js     801070d4 <copyuvm+0xa4>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010709b:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070a1:	39 75 0c             	cmp    %esi,0xc(%ebp)
801070a4:	76 43                	jbe    801070e9 <copyuvm+0xb9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801070a6:	8b 45 08             	mov    0x8(%ebp),%eax
801070a9:	31 c9                	xor    %ecx,%ecx
801070ab:	89 f2                	mov    %esi,%edx
801070ad:	e8 ee f7 ff ff       	call   801068a0 <walkpgdir>
801070b2:	85 c0                	test   %eax,%eax
801070b4:	74 3e                	je     801070f4 <copyuvm+0xc4>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
801070b6:	8b 18                	mov    (%eax),%ebx
801070b8:	f6 c3 01             	test   $0x1,%bl
801070bb:	74 44                	je     80107101 <copyuvm+0xd1>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070bd:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801070bf:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070c5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
801070cb:	e8 c0 b3 ff ff       	call   80102490 <kalloc>
801070d0:	85 c0                	test   %eax,%eax
801070d2:	75 8c                	jne    80107060 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801070d4:	83 ec 0c             	sub    $0xc,%esp
801070d7:	ff 75 e0             	pushl  -0x20(%ebp)
801070da:	e8 01 fe ff ff       	call   80106ee0 <freevm>
  return 0;
801070df:	83 c4 10             	add    $0x10,%esp
801070e2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801070e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070ef:	5b                   	pop    %ebx
801070f0:	5e                   	pop    %esi
801070f1:	5f                   	pop    %edi
801070f2:	5d                   	pop    %ebp
801070f3:	c3                   	ret    

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801070f4:	83 ec 0c             	sub    $0xc,%esp
801070f7:	68 dc 7b 10 80       	push   $0x80107bdc
801070fc:	e8 6f 92 ff ff       	call   80100370 <panic>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107101:	83 ec 0c             	sub    $0xc,%esp
80107104:	68 f6 7b 10 80       	push   $0x80107bf6
80107109:	e8 62 92 ff ff       	call   80100370 <panic>
8010710e:	66 90                	xchg   %ax,%ax

80107110 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107110:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107111:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107113:	89 e5                	mov    %esp,%ebp
80107115:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107118:	8b 55 0c             	mov    0xc(%ebp),%edx
8010711b:	8b 45 08             	mov    0x8(%ebp),%eax
8010711e:	e8 7d f7 ff ff       	call   801068a0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107123:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107125:	c9                   	leave  
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
80107126:	89 c2                	mov    %eax,%edx
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107128:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
8010712d:	83 e2 05             	and    $0x5,%edx
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107130:	05 00 00 00 80       	add    $0x80000000,%eax
80107135:	83 fa 05             	cmp    $0x5,%edx
80107138:	ba 00 00 00 00       	mov    $0x0,%edx
8010713d:	0f 45 c2             	cmovne %edx,%eax
}
80107140:	c3                   	ret    
80107141:	eb 0d                	jmp    80107150 <copyout>
80107143:	90                   	nop
80107144:	90                   	nop
80107145:	90                   	nop
80107146:	90                   	nop
80107147:	90                   	nop
80107148:	90                   	nop
80107149:	90                   	nop
8010714a:	90                   	nop
8010714b:	90                   	nop
8010714c:	90                   	nop
8010714d:	90                   	nop
8010714e:	90                   	nop
8010714f:	90                   	nop

80107150 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
80107153:	57                   	push   %edi
80107154:	56                   	push   %esi
80107155:	53                   	push   %ebx
80107156:	83 ec 1c             	sub    $0x1c,%esp
80107159:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010715c:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010715f:	8b 7d 10             	mov    0x10(%ebp),%edi
80107162:	85 db                	test   %ebx,%ebx
80107164:	75 40                	jne    801071a6 <copyout+0x56>
80107166:	eb 70                	jmp    801071d8 <copyout+0x88>
80107168:	90                   	nop
80107169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107170:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107173:	89 f1                	mov    %esi,%ecx
80107175:	29 d1                	sub    %edx,%ecx
80107177:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010717d:	39 d9                	cmp    %ebx,%ecx
8010717f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107182:	29 f2                	sub    %esi,%edx
80107184:	83 ec 04             	sub    $0x4,%esp
80107187:	01 d0                	add    %edx,%eax
80107189:	51                   	push   %ecx
8010718a:	57                   	push   %edi
8010718b:	50                   	push   %eax
8010718c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010718f:	e8 5c d5 ff ff       	call   801046f0 <memmove>
    len -= n;
    buf += n;
80107194:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107197:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010719a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801071a0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801071a2:	29 cb                	sub    %ecx,%ebx
801071a4:	74 32                	je     801071d8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801071a6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071a8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801071ab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801071ae:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801071b4:	56                   	push   %esi
801071b5:	ff 75 08             	pushl  0x8(%ebp)
801071b8:	e8 53 ff ff ff       	call   80107110 <uva2ka>
    if(pa0 == 0)
801071bd:	83 c4 10             	add    $0x10,%esp
801071c0:	85 c0                	test   %eax,%eax
801071c2:	75 ac                	jne    80107170 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801071c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801071c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801071cc:	5b                   	pop    %ebx
801071cd:	5e                   	pop    %esi
801071ce:	5f                   	pop    %edi
801071cf:	5d                   	pop    %ebp
801071d0:	c3                   	ret    
801071d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801071db:	31 c0                	xor    %eax,%eax
}
801071dd:	5b                   	pop    %ebx
801071de:	5e                   	pop    %esi
801071df:	5f                   	pop    %edi
801071e0:	5d                   	pop    %ebp
801071e1:	c3                   	ret    
