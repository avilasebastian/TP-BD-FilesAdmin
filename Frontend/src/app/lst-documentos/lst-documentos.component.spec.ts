import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LstDocumentosComponent } from './lst-documentos.component';

describe('LstDocumentosComponent', () => {
  let component: LstDocumentosComponent;
  let fixture: ComponentFixture<LstDocumentosComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LstDocumentosComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LstDocumentosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
